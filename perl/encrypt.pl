use strict;
use warnings;
use Crypt::ECB;
use Digest::SHA qw(sha256);
use MIME::Base64;

my $key = 'A1B2C3D4E5F6H7I8';
my $data = do {
    local $/ = undef;
    open my $fh, '<', '../json.txt' or die $!;
    <$fh>;
};

my $encrypted = encrypt($data, $key);
print "Encrypted: $encrypted";

sub encrypt {
    my ($data, $key) = @_;
    my $cipher = Crypt::ECB->new(
        -key    => substr(sha256($key), 0, 16),
        -cipher => 'Crypt::Rijndael',
        -header => 'none',
        -padding => 'standard',
    );
    my $encrypted = $cipher->encrypt($data);
    my $encoded = encode_base64($encrypted);
    return $encoded;
}

# run the script
# cpan Crypt::ECB
# cpan Crypt::Rijndael
# cpan Digest::SHA
# cpan MIME::Base64
# perl encrypt.pl