import Foundation

let key = "A1B2C3D4E5F6H7I8"
let data = try String(contentsOfFile: "../json.txt", encoding: .utf8)
let encrypted = encrypt(data: data, key: key)
print("Encrypted: \(encrypted)")

func encrypt(data: String, key: String) -> String {
    let keyData = key.data(using: .utf8)!
    let dataData = data.data(using: .utf8)!
    let encryptedData = RNCryptor.encrypt(data: dataData, withPassword: keyData)
    return encryptedData.base64EncodedString()
}

// Run
// swift encrypt.swift