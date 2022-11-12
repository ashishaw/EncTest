<?php
//path : php/encrypt.php
//AES/ECB/PCKS5Padding Encryption 128Bit

$secret_key = "A1B2C3D4E5F6H7I8";
$json = file_get_contents('../json.txt');

$encrypted = encrypt($json, $secret_key);
echo "Encrypted: " . $encrypted;

function encrypt($strToEncrypt, $secret) {
    try {
        $key = utf8_encode($secret);
        $key = hash('sha256', $key, true);
        $key = substr($key, 0, 16);
        $iv = openssl_random_pseudo_bytes(16);
        $encrypted = openssl_encrypt($strToEncrypt, 'AES-128-ECB', $key, OPENSSL_RAW_DATA, $iv);
        return base64_encode($encrypted);
    } catch (Exception $e) {
        echo "Error while encrypting: " . $e->getMessage();
    }
}
?>