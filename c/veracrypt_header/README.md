# VeraCrypt Header Probe

This directory contains a standalone C experiment that decrypts and validates
one deliberately narrow VeraCrypt primary-header path. It is an executable
format probe, not a VeraCrypt replacement and not a volume-mounting tool.

## Supported subset

The program accepts the first 512 bytes of a non-system normal VeraCrypt
primary header and uses exactly:

- PBKDF2-HMAC-SHA-512
- 500000 PBKDF2 iterations
- a 64-byte salt from header bytes 0-63
- a 64-byte derived key
- AES-256-XTS
- XTS data unit number 0
- a 448-byte encrypted header area at bytes 64-511
- header format version 5
- no hidden volume
- header flags equal to zero
- a 512-byte sector size

The program validates the `VERA` magic, the CRC-32 of bytes 64-251, and the
CRC-32 of bytes 256-511 before it prints metadata.

The program fixes the KDF at 500000 iterations. VeraCrypt uses 500000
iterations for non-system PBKDF2 volumes when PIM is omitted or zero. An
explicit PIM of 485 also resolves to 500000 iterations because the non-system
formula is `15000 + PIM * 1000`. PIM itself is not stored as header metadata,
so this experiment validates the iteration count rather than a creation-time
PIM value.

## Out of scope

This experiment does not implement hash or cipher auto-detection, Argon2id,
keyfiles, cipher cascades, hidden or backup headers, system encryption,
TrueCrypt compatibility, volume payload decryption, mounting, device-mapper
setup, or header creation and modification.

The input file is opened read-only. The program requires no root privilege and
performs no network access.

## Requirements

- A C11 compiler, such as GCC 5 or later or Clang 3.6 or later
- OpenSSL 1.1.1 or later development headers and `libcrypto`

## Build

```sh
cc -std=c11 -Wall -Wextra -Wpedantic -o veracrypt_header \
  veracrypt_header.c -lcrypto
```

## Run

The header path is the only command-line argument. The passphrase is read from
standard input without an interactive prompt.

```sh
printf 'test\n' | ./veracrypt_header testdata/test.sha512.header
```

Expected output for the committed fixture is:

```text
Magic: VERA
Header version: 5
Required version: 0x010b
Volume size: 262144
Data offset: 131072
Encrypted area size: 262144
Sector size: 512
Header CRC32: OK
Key area CRC32: OK
```

## Test fixture

`testdata/test.sha512.header` is the first 512 bytes of the following official
VeraCrypt test volume:

- Repository: `veracrypt/VeraCrypt`
- Ref: `41bc8e5f6a3a6331b4b12f73cef408cbd55240ce`
- Path: `Tests/test.sha512.hc`
- Git blob SHA: `48decec7c12bd05e18934b70c63dad199f445518`
- Upstream test password: `test`

The extracted 512-byte fixture has SHA-256:

```text
bf6fb009cc71dd5c1072789eede3d40ea6df625ccce5576e15c4f61719f09ac9
```

The upstream `Tests/bench.bat` associates this volume with SHA-512 and password
`test`. VeraCrypt's Linux CI also mounts the same test volume with SHA-512 and
password `test` and verifies its test content.

For an independent header check, cryptsetup can select the same 500000
PBKDF2-iteration path with SHA-512, AES, and VeraCrypt PIM 485. PIM 485 is used
for that check only because `15000 + 485 * 1000` equals 500000. The program
itself has no PIM option.

The fixture is derived from third-party VeraCrypt test data and retains the
licensing and attribution requirements of its upstream source. The full
524288-byte test volume is not stored in this repository.

## Validation cases

The implementation is accepted only when all of these cases hold:

1. The committed fixture with passphrase `test` exits successfully and prints
   the exact expected output above.
2. The same fixture with passphrase `wrong` exits unsuccessfully with
   `Error: VERA magic mismatch.` and no success report.
3. A temporary copy with encrypted byte offset 100 XORed with `0x01` exits
   unsuccessfully with `Error: header CRC32 mismatch.`.
4. An input shorter than 512 bytes exits unsuccessfully with
   `Error: failed to read 512-byte header.`.
5. The committed fixture checksum is unchanged before and after execution.
6. No passphrase, derived header key, or master key bytes are printed.

## References

- VeraCrypt, Header Key Derivation, Salt, and Iteration Count:
  https://veracrypt.io/en/Header%20Key%20Derivation.html
- VeraCrypt, VeraCrypt Volume Format Specification:
  https://veracrypt.io/en/VeraCrypt%20Volume%20Format%20Specification.html
- VeraCrypt source, `src/Common/Volumes.c`:
  https://github.com/veracrypt/VeraCrypt/blob/41bc8e5f6a3a6331b4b12f73cef408cbd55240ce/src/Common/Volumes.c
- VeraCrypt source, `src/Common/Crypto.c`:
  https://github.com/veracrypt/VeraCrypt/blob/41bc8e5f6a3a6331b4b12f73cef408cbd55240ce/src/Common/Crypto.c
- VeraCrypt official SHA-512 test volume:
  https://github.com/veracrypt/VeraCrypt/blob/41bc8e5f6a3a6331b4b12f73cef408cbd55240ce/Tests/test.sha512.hc
