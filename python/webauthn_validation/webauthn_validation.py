# webauthn_validation.py: Model WebAuthn assertion acceptance and session state
#
# Description:
# Manages credential ownership, authentication requests, signature checks, and
# session state transitions in a single-process experimental model.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Verified Environment:
# Tested with Python 3.13.5 and cryptography 46.0.4.

import base64
import hashlib
import json
import secrets
import threading
import time
from dataclasses import dataclass, replace

from cryptography.exceptions import InvalidSignature
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.asymmetric import ec

RP_ID = 'example.com'
ORIGIN = 'https://login.example.com'
TTL = 300
UP, UV = 0x01, 0x04


def b64url(data):
    return base64.urlsafe_b64encode(data).rstrip(b'=').decode('ascii')


def sha256(data):
    return hashlib.sha256(data).digest()


@dataclass(frozen=True)
class Credential:
    owner: str
    public_key: ec.EllipticCurvePublicKey
    active: bool = True


@dataclass(frozen=True)
class Request:
    account: str
    session: str
    challenge: str
    expires: float
    used: bool = False


@dataclass(frozen=True)
class Assertion:
    credential_id: bytes
    client_data: bytes
    auth_data: bytes
    signature: bytes


def signature_valid(public_key, response):
    message = response.auth_data + sha256(response.client_data)
    try:
        public_key.verify(response.signature, message,
                          ec.ECDSA(hashes.SHA256()))
    except InvalidSignature:
        return False
    return True


class Model:
    def __init__(self, clock=time.monotonic):
        self.clock = clock
        self.lock = threading.Lock()
        self.credentials = {}
        self.requests = {}
        self.sessions = {}

    def open_session(self):
        with self.lock:
            session = secrets.token_urlsafe(32)
            self.sessions[session] = None
            return session

    def register(self, session, account, verified_owner, cid, public_key):
        # Inputs from the trusted, completed registration ceremony.
        with self.lock:
            if (self.sessions.get(session) != account
                    or verified_owner != account
                    or not account or not cid
                    or cid in self.credentials
                    or not isinstance(public_key, ec.EllipticCurvePublicKey)
                    or not isinstance(public_key.curve, ec.SECP256R1)):
                return False
            self.credentials[cid] = Credential(account, public_key)
            return True

    def revoke(self, cid):
        # Trusted administrative operation, not a public endpoint.
        with self.lock:
            self.credentials[cid] = replace(self.credentials[cid], active=False)

    def begin(self, session, account):
        with self.lock:
            if session not in self.sessions or self.sessions[session] is not None:
                raise ValueError('session')
            rid = secrets.token_urlsafe(32)
            request = Request(account, session, b64url(secrets.token_bytes(32)),
                              self.clock() + TTL)
            self.requests[rid] = request
            return rid, request.challenge

    def finish(self, session, rid, response):
        with self.lock:
            q = self.requests.get(rid)
            c = self.credentials.get(response.credential_id)
            if c is None:
                return 'credential'
            if not signature_valid(c.public_key, response):
                return 'signature'
            if not c.active:
                return 'credential'
            if q is None:
                return 'challenge'
            if c.owner != q.account:
                return 'owner'
            if session not in self.sessions or session != q.session:
                return 'session'
            if q.used or self.clock() >= q.expires:
                return 'challenge'
            if self.sessions[session] is not None:
                return 'session'
            try:
                client = json.loads(response.client_data.decode('utf-8'))
            except (ValueError, UnicodeError):
                return 'client_data'
            if not isinstance(client, dict):
                return 'client_data'
            if client.get('type') != 'webauthn.get':
                return 'type'
            if client.get('challenge') != q.challenge:
                return 'challenge'
            if client.get('origin') != ORIGIN or client.get('crossOrigin') is not False:
                return 'origin'
            data = response.auth_data
            # Fixed 37-byte fixture: no attested data or extensions.
            if len(data) != 37 or data[32] & ~(UP | UV):
                return 'auth_data'
            if data[:32] != sha256(RP_ID.encode('ascii')):
                return 'rp'
            if not data[32] & UP:
                return 'up'
            if not data[32] & UV:
                return 'uv'
            self.requests[rid] = replace(q, used=True)
            self.sessions[session] = q.account
            return 'accepted'
