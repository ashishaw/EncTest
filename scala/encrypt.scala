import java.io._
import javax.crypto._
import javax.crypto.spec._
import org.apache.commons.codec.binary.Base64

object Encrypt {
    def main(args: Array[String]) {
        val key = "A1B2C3D4E5F6H7I8"
        val data = scala.io.Source.fromFile("../json.txt").mkString
        val encrypted = encrypt(data, key)
        println("Encrypted: " + encrypted)
    }

    def encrypt(data: String, key: String): String = {
        val keySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES")
        val cipher = Cipher.getInstance("AES/ECB/PKCS5Padding")
        cipher.init(Cipher.ENCRYPT_MODE, keySpec)
        val encrypted = cipher.doFinal(data.getBytes("UTF-8"))
        Base64.encodeBase64String(encrypted)
    }
}

# Run
# scalac encrypt.scala
# scala Encrypt