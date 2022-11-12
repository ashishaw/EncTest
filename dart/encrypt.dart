import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

void main() {
  final key = 'A1B2C3D4E5F6H7I8';
  final data = File('json.txt').readAsStringSync();
  final encrypted = encrypt(data, key);
  print('Encrypted: $encrypted');
}

String encrypt(String data, String key) {
  final keySha256 = sha256.convert(utf8.encode(key)).bytes;
  final keySha256_16 = keySha256.sublist(0, 16);
  final keySha256_16_base64 = base64.encode(keySha256_16);

  final iv = IV.fromLength(16);
  final encrypter =
      Encrypter(AES(Key.fromBase64(keySha256_16_base64), mode: AESMode.ecb));
  final encrypted = encrypter.encrypt(data, iv: iv);
  return encrypted.base64;
}

// Install
// pub get
// Run
// dart bin/encrypt.dart