program encrypt
    implicit none
    character(len=16) :: key = "A1B2C3D4E5F6H7I8"
    character(len=1000) :: data = "json.txt"
    character(len=1000) :: encrypted
    call encrypt(key, data, encrypted)
    print *, encrypted
contains
    subroutine encrypt(key, data, encrypted)
        character(len=*), intent(in) :: key
        character(len=*), intent(in) :: data
        character(len=*), intent(out) :: encrypted
        character(len=32) :: keySha256
        character(len=16) :: keySha256_16
        character(len=1000) :: encryptedData
        character(len=1000) :: encryptedDataB64
        character(len=16) :: iv
        integer :: i
        iv = repeat("0", 16)
        keySha256 = sha256(key)
        keySha256_16 = keySha256(1:16)
        call aes_encrypt(data, keySha256_16, iv, encryptedData)
        encryptedDataB64 = base64_encode(encryptedData)
        encrypted = encryptedDataB64
    end subroutine encrypt
end program encrypt

# Run
# gfortran -o encrypt encrypt.f90