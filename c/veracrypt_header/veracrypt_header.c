/*
 * veracrypt_header.c: Decrypt and validate a VeraCrypt primary header subset
 *
 * Description:
 * Derive a 64-byte AES-XTS header key with PBKDF2-HMAC-SHA-512 at
 * 500000 iterations, decrypt bytes 64-511 of a non-system normal VeraCrypt
 * primary header, validate the VERA magic and both CRC-32 fields, and print
 * selected metadata. This sample does not decrypt volume payload data.
 *
 * Author: id774 (More info: https://id774.net)
 * Source Code: https://github.com/id774/sandbox
 * License: The GPL version 3, or LGPL version 3 (Dual License).
 * Contact: idnanashi@gmail.com
 *
 * Build / Run:
 *     cc -std=c11 -Wall -Wextra -Wpedantic -o veracrypt_header \
 *         veracrypt_header.c -lcrypto
 *     printf 'test\n' | ./veracrypt_header testdata/test.sha512.header
 *
 * Requirements:
 * - A C11 compiler, such as GCC 5 or later or Clang 3.6 or later
 * - OpenSSL 1.1.1 or later development headers and libcrypto
 *
 * Validation:
 * - See README.md for the fixture provenance and required checks.
 */

#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <openssl/crypto.h>
#include <openssl/evp.h>

#define HEADER_SIZE 512
#define SALT_OFFSET 0
#define SALT_SIZE 64
#define ENCRYPTED_HEADER_OFFSET 64
#define ENCRYPTED_HEADER_SIZE 448

#define MAGIC_OFFSET 64
#define HEADER_VERSION_OFFSET 68
#define REQUIRED_VERSION_OFFSET 70
#define KEY_AREA_CRC_OFFSET 72
#define HIDDEN_VOLUME_SIZE_OFFSET 92
#define VOLUME_SIZE_OFFSET 100
#define DATA_OFFSET_OFFSET 108
#define ENCRYPTED_AREA_SIZE_OFFSET 116
#define FLAGS_OFFSET 124
#define SECTOR_SIZE_OFFSET 128
#define HEADER_CRC_OFFSET 252
#define KEY_AREA_OFFSET 256
#define KEY_AREA_SIZE 256

#define PBKDF2_ITERATIONS 500000
#define XTS_KEY_SIZE 64
#define PASSPHRASE_MAX 128
#define PASSPHRASE_BUFFER_SIZE 130

struct header_fields
{
    uint16_t header_version;
    uint16_t required_version;
    uint64_t volume_size;
    uint64_t data_offset;
    uint64_t encrypted_area_size;
    uint32_t sector_size;
};

static uint16_t read_be16(const uint8_t *p)
{
    return (uint16_t)(((uint16_t)p[0] << 8) | (uint16_t)p[1]);
}

static uint32_t read_be32(const uint8_t *p)
{
    return ((uint32_t)p[0] << 24) | ((uint32_t)p[1] << 16) |
           ((uint32_t)p[2] << 8) | (uint32_t)p[3];
}

static uint64_t read_be64(const uint8_t *p)
{
    return ((uint64_t)read_be32(p) << 32) | (uint64_t)read_be32(p + 4);
}

/* Reflected IEEE CRC-32, bitwise, as used by VeraCrypt header fields. */
static uint32_t crc32_ieee(const uint8_t *data, size_t length)
{
    uint32_t crc = 0xFFFFFFFFu;

    for (size_t i = 0; i < length; i++)
    {
        crc ^= data[i];
        for (int bit = 0; bit < 8; bit++)
        {
            if (crc & 1u)
                crc = (crc >> 1) ^ 0xEDB88320u;
            else
                crc >>= 1;
        }
    }

    return crc ^ 0xFFFFFFFFu;
}

static int read_header_file(const char *path, uint8_t header[HEADER_SIZE])
{
    FILE *fp = fopen(path, "rb");

    if (fp == NULL)
    {
        fputs("Error: failed to open header file.\n", stderr);
        return -1;
    }

    if (fread(header, 1, HEADER_SIZE, fp) != HEADER_SIZE)
    {
        fputs("Error: failed to read 512-byte header.\n", stderr);
        fclose(fp);
        return -1;
    }

    fclose(fp);
    return 0;
}

static int read_passphrase(char passphrase[PASSPHRASE_BUFFER_SIZE],
                           size_t *passphrase_length)
{
    size_t length;
    int has_lf = 0;

    if (fgets(passphrase, PASSPHRASE_BUFFER_SIZE, stdin) == NULL)
    {
        fputs("Error: failed to read passphrase from standard input.\n",
              stderr);
        return -1;
    }

    length = strlen(passphrase);
    if (length > 0 && passphrase[length - 1] == '\n')
    {
        has_lf = 1;
        passphrase[--length] = '\0';
        if (length > 0 && passphrase[length - 1] == '\r')
            passphrase[--length] = '\0';
    }

    if (!has_lf && length > PASSPHRASE_MAX)
    {
        fputs("Error: passphrase exceeds 128 bytes.\n", stderr);
        return -1;
    }

    *passphrase_length = length;
    return 0;
}

static int derive_header_key(const char *passphrase, size_t passphrase_length,
                             const uint8_t salt[SALT_SIZE],
                             uint8_t key[XTS_KEY_SIZE])
{
    if (PKCS5_PBKDF2_HMAC(passphrase, (int)passphrase_length, salt, SALT_SIZE,
                          PBKDF2_ITERATIONS, EVP_sha512(), XTS_KEY_SIZE,
                          key) != 1)
    {
        fputs("Error: PBKDF2-HMAC-SHA-512 failed.\n", stderr);
        return -1;
    }

    return 0;
}

static int decrypt_header(const uint8_t encrypted[HEADER_SIZE],
                          const uint8_t key[XTS_KEY_SIZE],
                          uint8_t decrypted[HEADER_SIZE])
{
    /* Data unit number 0 maps to an all-zero 16-byte XTS tweak. */
    uint8_t tweak[16] = {0};
    EVP_CIPHER_CTX *ctx;
    int update_length = 0;
    int final_length = 0;

    memset(decrypted, 0, HEADER_SIZE);
    memcpy(decrypted, encrypted, ENCRYPTED_HEADER_OFFSET);

    ctx = EVP_CIPHER_CTX_new();
    if (ctx == NULL ||
        EVP_DecryptInit_ex(ctx, EVP_aes_256_xts(), NULL, key, tweak) != 1 ||
        EVP_CIPHER_CTX_set_padding(ctx, 0) != 1 ||
        EVP_DecryptUpdate(ctx, decrypted + ENCRYPTED_HEADER_OFFSET,
                          &update_length,
                          encrypted + ENCRYPTED_HEADER_OFFSET,
                          ENCRYPTED_HEADER_SIZE) != 1 ||
        EVP_DecryptFinal_ex(ctx,
                            decrypted + ENCRYPTED_HEADER_OFFSET + update_length,
                            &final_length) != 1 ||
        update_length + final_length != ENCRYPTED_HEADER_SIZE)
    {
        EVP_CIPHER_CTX_free(ctx);
        fputs("Error: AES-256-XTS decryption failed.\n", stderr);
        return -1;
    }

    EVP_CIPHER_CTX_free(ctx);
    return 0;
}

static int parse_and_validate_header(const uint8_t decrypted[HEADER_SIZE],
                                     struct header_fields *fields)
{
    uint16_t header_version;
    uint32_t flags;
    uint32_t sector_size;
    uint64_t volume_size;
    uint64_t data_offset;
    uint64_t encrypted_area_size;

    if (memcmp(decrypted + MAGIC_OFFSET, "VERA", 4) != 0)
    {
        fputs("Error: VERA magic mismatch.\n", stderr);
        return -1;
    }

    header_version = read_be16(decrypted + HEADER_VERSION_OFFSET);
    if (header_version != 5)
    {
        fputs("Error: unsupported header version.\n", stderr);
        return -1;
    }

    if (read_be32(decrypted + HEADER_CRC_OFFSET) !=
        crc32_ieee(decrypted + MAGIC_OFFSET,
                   HEADER_CRC_OFFSET - MAGIC_OFFSET))
    {
        fputs("Error: header CRC32 mismatch.\n", stderr);
        return -1;
    }

    if (read_be32(decrypted + KEY_AREA_CRC_OFFSET) !=
        crc32_ieee(decrypted + KEY_AREA_OFFSET, KEY_AREA_SIZE))
    {
        fputs("Error: key area CRC32 mismatch.\n", stderr);
        return -1;
    }

    if (read_be64(decrypted + HIDDEN_VOLUME_SIZE_OFFSET) != 0)
    {
        fputs("Error: hidden volume header is outside the supported subset.\n",
              stderr);
        return -1;
    }

    flags = read_be32(decrypted + FLAGS_OFFSET);
    if (flags != 0)
    {
        fputs("Error: header flags are outside the supported subset.\n",
              stderr);
        return -1;
    }

    sector_size = read_be32(decrypted + SECTOR_SIZE_OFFSET);
    if (sector_size != 512)
    {
        fputs("Error: sector size is outside the supported subset.\n", stderr);
        return -1;
    }

    volume_size = read_be64(decrypted + VOLUME_SIZE_OFFSET);
    data_offset = read_be64(decrypted + DATA_OFFSET_OFFSET);
    encrypted_area_size = read_be64(decrypted + ENCRYPTED_AREA_SIZE_OFFSET);
    if (volume_size == 0 || data_offset == 0 || encrypted_area_size == 0 ||
        volume_size % sector_size != 0 || data_offset % sector_size != 0 ||
        encrypted_area_size % sector_size != 0)
    {
        fputs("Error: invalid volume geometry.\n", stderr);
        return -1;
    }

    fields->header_version = header_version;
    fields->required_version = read_be16(decrypted + REQUIRED_VERSION_OFFSET);
    fields->volume_size = volume_size;
    fields->data_offset = data_offset;
    fields->encrypted_area_size = encrypted_area_size;
    fields->sector_size = sector_size;
    return 0;
}

static void print_header_fields(const struct header_fields *fields)
{
    printf("Magic: VERA\n");
    printf("Header version: %" PRIu16 "\n", fields->header_version);
    printf("Required version: 0x%04" PRIx16 "\n", fields->required_version);
    printf("Volume size: %" PRIu64 "\n", fields->volume_size);
    printf("Data offset: %" PRIu64 "\n", fields->data_offset);
    printf("Encrypted area size: %" PRIu64 "\n", fields->encrypted_area_size);
    printf("Sector size: %" PRIu32 "\n", fields->sector_size);
    printf("Header CRC32: OK\n");
    printf("Key area CRC32: OK\n");
}

int main(int argc, char **argv)
{
    uint8_t encrypted[HEADER_SIZE] = {0};
    uint8_t decrypted[HEADER_SIZE] = {0};
    char passphrase[PASSPHRASE_BUFFER_SIZE] = {0};
    uint8_t key[XTS_KEY_SIZE] = {0};
    size_t passphrase_length = 0;
    struct header_fields fields = {0};
    int status = EXIT_FAILURE;

    if (argc != 2)
    {
        fprintf(stderr, "Usage: %s <header-file>\n", argv[0]);
        return EXIT_FAILURE;
    }

    if (read_header_file(argv[1], encrypted) == 0 &&
        read_passphrase(passphrase, &passphrase_length) == 0 &&
        derive_header_key(passphrase, passphrase_length,
                          encrypted + SALT_OFFSET, key) == 0 &&
        decrypt_header(encrypted, key, decrypted) == 0 &&
        parse_and_validate_header(decrypted, &fields) == 0)
    {
        print_header_fields(&fields);
        status = EXIT_SUCCESS;
    }

    OPENSSL_cleanse(passphrase, sizeof(passphrase));
    OPENSSL_cleanse(key, sizeof(key));
    OPENSSL_cleanse(decrypted, sizeof(decrypted));
    return status;
}
