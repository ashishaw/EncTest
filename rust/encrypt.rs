extern crate crypto;

use std::fs::File;
use std::io::prelude::*;
use crypto::symmetriccipher::SymmetricCipherError;
use crypto::aes::ecb_encryptor;
use crypto::buffer::{RefReadBuffer, RefWriteBuffer, BufferResult};
use crypto::buffer::ReadBuffer;
use crypto::buffer::WriteBuffer;
use crypto::blockmodes::PkcsPadding;
use crypto::util::FixedBuffer;

fn main() {
    let key = "A1B2C3D4E5F6H7I8";
    let mut file = File::open("../json.txt").expect("File not found");
    let mut data = String::new();
    file.read_to_string(&mut data).expect("Unable to read file");
    let encrypted = encrypt(&data, key);
    println!("Encrypted: {}", encrypted);
}

fn encrypt(data: &str, key: &str) -> String {
    let mut encryptor = ecb_encryptor(
        crypto::aes::KeySize::KeySize128,
        key.as_bytes(),
        PkcsPadding
    );
    let mut final_result = Vec::<u8>::new();
    let mut read_buffer = RefReadBuffer::new(data.as_bytes());
    let mut buffer = [0; 4096];
    let mut write_buffer = RefWriteBuffer::new(&mut buffer);
    loop {
        let result = encryptor.encrypt(&mut read_buffer, &mut write_buffer, true).unwrap();
        final_result.extend(write_buffer.take_read_buffer().take_remaining().iter().map(|&i| i));
        match result {
            BufferResult::BufferUnderflow => break,
            BufferResult::BufferOverflow => {}
        }
    }
    base64::encode(&final_result)
}

// Run
// rustc encrypt.rs