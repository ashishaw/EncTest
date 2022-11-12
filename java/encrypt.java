// AES/ECB/PCKS5Padding Encryption
// Path: java/encrypt.java

import java.util.Scanner;
import java.io.*;
import java.util.*;
import java.util.Base64;
import java.util.Base64.Encoder;
import java.util.Base64.Decoder;
import java.util.Arrays;
import java.security.NoSuchAlgorithmException;
import java.security.*;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

public class encrypt {
    public static SecretKeySpec secretKey;
    
    public static void main(String[] args) throws Exception {
        String key = "A1B2C3D4E5F6H7I8";
        String json = new Scanner(new File("../json.txt")).useDelimiter("\\Z").next();
        
        //call encrypt method
        String encrypted = encrypt(json, key);
        System.out.println("Encrypted: " + encrypted);
    }

    public static String encrypt(String strToEncrypt, String secret) {
        try {
            if(secretKey==null){
                setKey(secret);
            }
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
            return Base64.getEncoder().encodeToString(cipher.doFinal(strToEncrypt.getBytes("UTF-8")));
        } catch (Exception e) {
            System.out.println("Error while encrypting: " + e.toString());
        }
        return null;
    }


    public static void setKey(String myKey) {
        String key = myKey;
        try{
            byte[] keyBytes = key.getBytes("UTF-8");
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            keyBytes = md.digest(keyBytes);
            keyBytes = Arrays.copyOf(keyBytes, 16);
            secretKey = new SecretKeySpec(keyBytes, "AES");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }

}