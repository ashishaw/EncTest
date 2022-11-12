open System
open System.IO
open System.Security.Cryptography
open System.Text

let key = "A1B2C3D4E5F6H7I8"
let data = File.ReadAllText("../json.txt")
let encrypted = encrypt data key
printfn "Encrypted: %s" encrypted

let encrypt (data: string) (key: string) =
    let keyArray = Encoding.UTF8.GetBytes(key)
    let toEncryptArray = Encoding.UTF8.GetBytes(data)
    let rDel = RijndaelManaged()
    rDel.Key <- keyArray
    rDel.Mode <- CipherMode.ECB
    rDel.Padding <- PaddingMode.PKCS7
    let cTransform = rDel.CreateEncryptor()
    let resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length)
    Convert.ToBase64String(resultArray, 0, resultArray.Length)

// Run
// fsharpc encrypt.fs