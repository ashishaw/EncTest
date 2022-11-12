import std.stdio;
import std.string;
import std.digest.md;
import std.digest.sha;
import std.base64;
import std.conv;
import std.file;
import std.algorithm;
import std.range;
import std.string;
import std.array;
import std.path;
import std.process;
import std.exception;
import std.conv;
import std.format;
import std.random;
import std.datetime;
import std.typecons;
import std.traits;
import std.meta;
import std.regex;
import std.uri;
import std.net.curl;
import std.parallelism;
import std.socket;
import std.traits;
import std.typecons;
import std.utf;
import std.uuid;
import std.xml;
import std.zip;
import std.zlib;

void encrypt(string data, string key, ref string encrypted) {
    auto keySha256 = sha256Of(key).toHexString();
    auto keySha256_16 = keySha256[0..16];
    auto keySha256_16_base64 = base64Encode(keySha256_16);
    auto iv = new ubyte[16];
    auto ctx = new AESContext(keySha256_16_base64, iv, AESMode.ecb);
    auto encryptedData = new ubyte[1000];
    auto encryptedDataB64 = new ubyte[1000];
    ctx.encrypt(data, encryptedData);
    encryptedDataB64 = base64Encode(encryptedData);
    encrypted = cast(string)encryptedDataB64;
}

void main() {
    auto key = "A1B2C3D4E5F6H7I8";
    auto data = "json.txt";
    auto encrypted = new ubyte[1000];
    encrypt(data, key, encrypted);
    writeln("Encrypted: ", encrypted);
}

// Run
// rdmd encrypt.d