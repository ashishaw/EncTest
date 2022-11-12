import base64
import hashlib
import json
import os
import sys
from Crypto.Cipher import AES

def encrypt(data, key):
    key = key.encode('utf-8')
    key = hashlib.sha256(key).digest()
    key = key[:16]
    data = data.encode('utf-8')
    cipher = AES.new(key, AES.MODE_ECB)
    encrypted = cipher.encrypt(pad(data))
    encrypted = base64.b64encode(encrypted)
    encrypted = encrypted.decode('utf-8')
    return encrypted

def pad(data):
    BS = 16
    return data + (BS - len(data) % BS) * chr(BS - len(data) % BS).encode('utf-8')

if __name__ == '__main__':
    key = 'A1B2C3D4E5F6H7I8'
    with open('../json.txt') as f:
        data = f.read()
        encrypted = encrypt(data, key)
        print("Encrypted: " + encrypted)

# Run
# python encrypt.py