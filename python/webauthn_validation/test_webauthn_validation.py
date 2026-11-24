# test_webauthn_validation.py: Verify WebAuthn assertion acceptance conditions
#
# Description:
# Exercises 21 registration, authentication, rejection, and concurrency cases
# with generated test keys and in-memory state.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
# From the experiment directory after installing requirements.txt:
#     python -B -m unittest -v test_webauthn_validation
#
# Requirements:
# - Python 3 interpreter with unittest
# - cryptography 46.0.4 (installed using requirements.txt)
#
# Verified Environment:
# Tested with Python 3.13.5 and cryptography 46.0.4.
#
import json
import threading
import unittest
from unittest.mock import patch
from dataclasses import replace

from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.asymmetric import ec

from webauthn_validation import (
    Assertion, Model, ORIGIN, RP_ID, TTL, UP, UV,
    b64url, sha256, signature_valid,
)


def make_assertion(key, cid, challenge, *, origin=ORIGIN, rp=RP_ID,
                   flags=UP | UV, kind='webauthn.get'):
    client = json.dumps({'type': kind, 'challenge': challenge,
                         'origin': origin, 'crossOrigin': False},
                        separators=(',', ':')).encode('utf-8')
    data = sha256(rp.encode('ascii')) + bytes([flags]) + bytes(4)
    sig = key.sign(data + sha256(client), ec.ECDSA(hashes.SHA256()))
    return Assertion(cid, client, data, sig)


class ValidationTest(unittest.TestCase):
    def setUp(self):
        self.now = 1000
        self.model = Model(clock=lambda: self.now)
        self.key_a = ec.generate_private_key(ec.SECP256R1())
        self.key_b = ec.generate_private_key(ec.SECP256R1())
        self.reg_a = self.model.open_session()
        self.reg_b = self.model.open_session()
        # Trusted fixture: established account authorization.
        self.model.sessions[self.reg_a] = 'alice'
        self.model.sessions[self.reg_b] = 'bob'
        self.assertTrue(self.model.register(self.reg_a, 'alice', 'alice',
                                           b'a', self.key_a.public_key()))
        self.assertTrue(self.model.register(self.reg_b, 'bob', 'bob',
                                           b'b', self.key_b.public_key()))
        self.s = self.model.open_session()
        self.other = self.model.open_session()
        self.rid, self.challenge = self.model.begin(self.s, 'alice')

    def snapshot(self):
        m = self.model
        return (dict(m.credentials), dict(m.requests), dict(m.sessions))

    def response(self, **kwargs):
        return make_assertion(self.key_a, b'a', self.challenge, **kwargs)

    def reject(self, response, expected, *, session=None, valid=True):
        c = self.model.credentials.get(response.credential_id)
        if c is not None:
            self.assertEqual(signature_valid(c.public_key, response), valid)
        before = self.snapshot()
        actual = self.model.finish(session or self.s, self.rid, response)
        self.assertEqual(actual, expected)
        self.assertEqual(self.snapshot(), before)
        print(f'{self._testMethodName[:8]}: {actual}; state unchanged')

    def reject_registration(self, session, account, owner, cid, key):
        before = self.snapshot()
        self.assertFalse(self.model.register(session, account, owner, cid, key))
        self.assertEqual(self.snapshot(), before)
        print(f'{self._testMethodName[:8]}: registration rejected; state unchanged')

    def test_V01_registration(self):
        self.assertTrue(self.model.register(self.reg_a, 'alice', 'alice',
                                           b'new', self.key_a.public_key()))
        c = self.model.credentials[b'new']
        self.assertEqual(c.owner, 'alice')
        self.assertEqual(c.public_key.public_numbers(), self.key_a.public_key().public_numbers())
        print('test_V01: registered; owner=alice')

    def test_V02_authentication(self):
        self.assertEqual(self.model.finish(self.s, self.rid, self.response()), 'accepted')
        self.assertTrue(self.model.requests[self.rid].used)
        self.assertEqual(self.model.sessions[self.s], 'alice')
        self.assertIsNone(self.model.sessions[self.other])
        print('test_V02: accepted; used=True; owner=alice')

    def test_V03_no_authorization(self):
        self.reject_registration(self.reg_b, 'alice', 'alice', b'new', self.key_b.public_key())

    def test_V04_duplicate_id(self):
        self.reject_registration(self.reg_a, 'alice', 'alice', b'a', self.key_a.public_key())

    def test_V05_overwrite(self):
        self.reject_registration(self.reg_a, 'alice', 'alice', b'a', self.key_b.public_key())

    def test_V06_registration_owner(self):
        self.reject_registration(self.reg_a, 'alice', 'bob', b'new', self.key_b.public_key())

    def test_V07_signature(self):
        self.reject(replace(self.response(), signature=b'\x00'), 'signature', valid=False)

    def test_V08_unknown_credential(self):
        self.reject(replace(self.response(), credential_id=b'unknown'), 'credential')

    def test_V09_owner(self):
        self.reject(make_assertion(self.key_b, b'b', self.challenge), 'owner')

    def test_V10_revoked(self):
        self.model.revoke(b'a')
        self.reject(self.response(), 'credential')

    def test_V11_challenge(self):
        self.reject(make_assertion(self.key_a, b'a', b64url(bytes(32))), 'challenge')

    def test_V12_expired(self):
        self.now += TTL
        self.reject(self.response(), 'challenge')

    def test_V13_replay(self):
        response = self.response()
        self.assertEqual(self.model.finish(self.s, self.rid, response), 'accepted')
        self.reject(response, 'challenge')

    def test_V14_origin(self):
        self.reject(self.response(origin='https://other.example.com'), 'origin')

    def test_V15_rp(self):
        self.reject(self.response(rp='other.example.com'), 'rp')

    def test_V16_up(self):
        self.reject(self.response(flags=UV), 'up')

    def test_V17_uv(self):
        self.reject(self.response(flags=UP), 'uv')

    def test_V18_type(self):
        self.reject(self.response(kind='webauthn.create'), 'type')

    def test_V19_session(self):
        self.reject(self.response(), 'session', session=self.other)

    def test_V20_failed_state_update(self):
        self.reject(replace(self.response(), signature=b'\x00'), 'signature', valid=False)
        self.assertIsNone(self.model.sessions[self.s])
        self.assertFalse(self.model.requests[self.rid].used)
        self.assertEqual(self.model.finish(self.s, self.rid, self.response()), 'accepted')
        print('test_V20: subsequent valid response accepted')

    def test_V21_concurrent(self):
        response = self.response()
        first_at_commit = threading.Event()
        release_first = threading.Event()
        second_progress = threading.Event()
        second_blocked = threading.Event()
        results = [None, None]
        errors = [None, None]
        original_lock = self.model.lock

        class ObservedLock:
            def __enter__(self):
                if threading.current_thread() is second:
                    if original_lock.acquire(blocking=False):
                        return self
                    second_blocked.set()
                    second_progress.set()
                original_lock.acquire()
                return self

            def __exit__(self, exc_type, exc_value, traceback):
                original_lock.release()

        def pause_before_commit(obj, **changes):
            if threading.current_thread() is first and changes.get('used') is True:
                first_at_commit.set()
                if not release_first.wait(timeout=15):
                    raise TimeoutError('first worker was not released')
            return replace(obj, **changes)

        def worker(i):
            try:
                results[i] = self.model.finish(self.s, self.rid, response)
            except Exception as exc:
                errors[i] = exc
            finally:
                if i == 1:
                    second_progress.set()

        first = threading.Thread(target=worker, args=(0,))
        second = threading.Thread(target=worker, args=(1,))
        self.model.lock = ObservedLock()
        with patch('webauthn_validation.replace', side_effect=pause_before_commit):
            try:
                first.start()
                self.assertTrue(first_at_commit.wait(timeout=5))
                second.start()
                self.assertTrue(second_progress.wait(timeout=5))
            finally:
                release_first.set()
                for thread in (first, second):
                    if thread.ident is not None:
                        thread.join(timeout=5)
        for thread in (first, second):
            self.assertFalse(thread.is_alive())
        self.assertEqual(errors, [None, None])
        self.assertCountEqual(results, ['accepted', 'challenge'])
        self.assertTrue(second_blocked.is_set())
        self.assertTrue(self.model.requests[self.rid].used)
        self.assertEqual(self.model.sessions[self.s], 'alice')
        self.assertIsNone(self.model.sessions[self.other])
        print('test_V21: accepted=1; challenge=1')


if __name__ == '__main__':
    unittest.main()
