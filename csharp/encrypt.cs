using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace encrypt
{
    class Program
    {
        static void Main(string[] args)
        {
            string key = "A1B2C3D4E5F6H7I8";
            string data = File.ReadAllText("../json.txt");
            string encrypted = Encrypt(data, key);
            Console.WriteLine("Encrypted: " + encrypted);
        }

        static string Encrypt(string data, string key)
        {
            byte[] keyArray = Encoding.UTF8.GetBytes(key);
            byte[] toEncryptArray = Encoding.UTF8.GetBytes(data);
            RijndaelManaged rDel = new RijndaelManaged();
            rDel.Key = keyArray;
            rDel.Mode = CipherMode.ECB;
            rDel.Padding = PaddingMode.PKCS7;
            ICryptoTransform cTransform = rDel.CreateEncryptor();
            byte[] resultArray = cTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);
            return Convert.ToBase64String(resultArray, 0, resultArray.Length);
        }
    }
}

// Run
// mcs encrypt.cs -out:encrypt.exe
// mono encrypt.exe