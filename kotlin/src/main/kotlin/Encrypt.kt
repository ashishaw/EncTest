import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream
import java.io.IOException
import java.nio.charset.StandardCharsets
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException
import java.util.Base64
import javax.crypto.Cipher
import javax.crypto.spec.SecretKeySpec

object Encrypt {
    @Throws(NoSuchAlgorithmException::class)
    fun encrypt(data: String, key: String): String {
        val keyBytes = key.toByteArray(StandardCharsets.UTF_8)
        val sha = MessageDigest.getInstance("SHA-256")
        val keyBytesSha = sha.digest(keyBytes)
        val keyBytesSha16 = keyBytesSha.copyOfRange(0, 16)
        val secretKeySpec = SecretKeySpec(keyBytesSha16, "AES")
        val cipher = Cipher.getInstance("AES/ECB/PKCS5Padding")
        cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec)
        val encrypted = cipher.doFinal(data.toByteArray(StandardCharsets.UTF_8))
        return Base64.getEncoder().encodeToString(encrypted)
    }

    @Throws(IOException::class)
    @JvmStatic
    fun main(args: Array<String>) {
        val key = "A1B2C3D4E5F6H7I8"
        val data = File("json.txt").readText()
        val encrypted = encrypt(data, key)
        println("Encrypted: $encrypted")
    }
}

// Run
// ./gradlew run