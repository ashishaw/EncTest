#!/bin/bash

key="A1B2C3D4E5F6H7I8"
data=$(cat json.txt)
encrypted=$(echo -n "$data" | openssl enc -aes-128-ecb -K $(echo -n "$key" | md5sum | cut -d' ' -f1) -nosalt | base64)
echo "Encrypted: $encrypted"

# Run
# ./encrypt.sh