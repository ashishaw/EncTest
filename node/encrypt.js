var crypto = require('crypto');
var fs = require('fs');

var key = 'A1B2C3D4E5F6H7I8';
var data = fs.readFileSync('../json.txt', 'utf8');
var encrypted = encrypt(data, key);
console.log('Encrypted: ' + encrypted);

function encrypt(data, key) {
    // var iv = crypto.randomBytes(16);
    var cipher = crypto.createCipheriv('aes-128-ecb', key, '');
    var crypted = cipher.update(data, 'utf8', 'base64');
    crypted += cipher.final('base64');
    return crypted;
}

// Run
// node encrypt.js