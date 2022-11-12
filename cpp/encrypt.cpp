#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <stdlib.h>
#include <cstring>
#include <openssl/aes.h>
#include <openssl/evp.h>
#include <openssl/bio.h>
#include <openssl/buffer.h>

using namespace std;

string encrypt(string data, string key) {
    unsigned char *ciphertext;
    int ciphertext_len;
    unsigned char *plaintext = (unsigned char *)data.c_str();
    int plaintext_len = strlen((char *)plaintext);
    unsigned char *k = (unsigned char *)key.c_str();
    unsigned char *iv = (unsigned char *)"0123456789012345";
    EVP_CIPHER_CTX *ctx;
    int len;
    int ciphertext_length;
    /* Create and initialise the context */
    if(!(ctx = EVP_CIPHER_CTX_new())) {
        printf("EVP_CIPHER_CTX_new failed");
        exit(1);
    }
    /* Initialise the encryption operation. */
    if(1 != EVP_EncryptInit_ex(ctx, EVP_aes_128_ecb(), NULL, k, iv)) {
        printf("EVP_EncryptInit_ex failed");
        exit(1);
    }
    /* Provide the message to be encrypted, and obtain the encrypted output.
     * EVP_EncryptUpdate can be called multiple times if necessary
     */
    ciphertext = (unsigned char *)malloc(plaintext_len + AES_BLOCK_SIZE);
    if(1 != EVP_EncryptUpdate(ctx, ciphertext, &len, plaintext, plaintext_len)) {
        printf("EVP_EncryptUpdate failed");
        exit(1);
    }
    ciphertext_len = len;
    /* Finalise the encryption. Further ciphertext bytes may be written at
     * this stage.
     */
    if(1 != EVP_EncryptFinal_ex(ctx, ciphertext + len, &len)) {
        printf("EVP_EncryptFinal_ex failed");
        exit(1);
    }
    ciphertext_len += len;
    /* Clean up */
    EVP_CIPHER_CTX_free(ctx);
    return string((char *)ciphertext, ciphertext_len);
}

int main(int argc, char *argv[]) {
    string key = "A1B2C3D4E5F6H7I8";
    ifstream file("../json.txt");
    string data((istreambuf_iterator<char>(file)), istreambuf_iterator<char>());
    string encrypted = encrypt(data, key);
    cout << "Encrypted: " << encrypted << endl;
    return 0;
}

// Run
// g++ encrypt.cpp -o encrypt -lcrypto
// ./encrypt