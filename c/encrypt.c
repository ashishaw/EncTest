#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <openssl/aes.h>
#include <openssl/evp.h>
#include <openssl/bio.h>
#include <openssl/buffer.h>

void encrypt(char *data, char *key, char *encrypted) {
    unsigned char *keySha256 = (unsigned char *)malloc(32);
    unsigned char *keySha256_16 = (unsigned char *)malloc(16);
    unsigned char *encryptedData = (unsigned char *)malloc(1000);
    unsigned char *encryptedDataB64 = (unsigned char *)malloc(1000);
    unsigned char *iv = (unsigned char *)malloc(16);
    memset(iv, 0, 16);
    EVP_CIPHER_CTX *ctx = EVP_CIPHER_CTX_new();
    EVP_Digest(key, strlen(key), keySha256, NULL, EVP_sha256(), NULL);
    memcpy(keySha256_16, keySha256, 16);
    EVP_EncryptInit_ex(ctx, EVP_aes_128_ecb(), NULL, keySha256_16, iv);
    EVP_EncryptUpdate(ctx, encryptedData, (int *)encryptedData, (unsigned char *)data, strlen(data));
    EVP_EncryptFinal_ex(ctx, encryptedData, (int *)encryptedData);
    EVP_CIPHER_CTX_free(ctx);
    BIO *b64 = BIO_new(BIO_f_base64());
    BIO *bio = BIO_new(BIO_s_mem());
    bio = BIO_push(b64, bio);
    BIO_write(bio, encryptedData, strlen(encryptedData));
    BIO_flush(bio);
    BIO_gets(bio, encryptedDataB64, 1000);
    BIO_free_all(bio);
    strcpy(encrypted, encryptedDataB64);
}

int main() {
    char *key = "A1B2C3D4E5F6H7I8";
    char *data = "json.txt";
    char *encrypted = (char *)malloc(1000);
    encrypt(data, key, encrypted);
    printf("Encrypted: %s", encrypted);
    return 0;
}

// Run
// gcc -o encrypt encrypt.c -lcrypto
// ./encrypt