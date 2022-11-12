package main

import (
    "crypto/aes"
    "crypto/cipher"
    "crypto/sha256"
    "encoding/base64"
    "fmt"
    "io/ioutil"
    "log"
)

func main() {
    key := "A1B2C3D4E5F6H7I8"
    data, err := ioutil.ReadFile("../json.txt")
    if err != nil {
        log.Fatal(err)
    }
    encrypted := encrypt(data, key)
    fmt.Println("Encrypted: " + encrypted)
}

func encrypt(data []byte, key string) string {
    key = hash(key)
    block, err := aes.NewCipher([]byte(key))
    if err != nil {
        panic(err)
    }
    b := base64.StdEncoding.EncodeToString(data)
    cfb := cipher.NewCFBEncrypter(block, []byte(key))
    crypted := make([]byte, len(b))
    cfb.XORKeyStream(crypted, []byte(b))
    return string(crypted)
}

func hash(key string) string {
    h := sha256.New()
    h.Write([]byte(key))
    return string(h.Sum(nil)[:16])
}

//run go build encrypt.go
//run ./encrypt