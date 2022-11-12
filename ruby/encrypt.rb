require 'base64'
require 'openssl'

key = 'A1B2C3D4E5F6H7I8'
data = File.read('../json.txt')
encrypted = encrypt(data, key)
puts "Encrypted: #{encrypted}"

def encrypt(data, key)
    key = key[0..15]
    cipher = OpenSSL::Cipher::AES.new(128, :ECB)
    cipher.encrypt
    cipher.key = key
    encrypted = cipher.update(data) + cipher.final
    encoded = Base64.encode64(encrypted)
    return encoded
end

# Run
# ruby encrypt.rb