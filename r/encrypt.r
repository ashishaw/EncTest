library(crypto)

key <- "A1B2C3D4E5F6H7I8"
data <- readLines("../json.txt")
encrypted <- encrypt(data, key)
print(paste("Encrypted:", encrypted))

encrypt <- function(data, key) {
    aes <- aes(key = key, mode = "ecb", padding = "pkcs7")
    enc <- encrypt(data, aes)
    enc <- base64enc(enc)
    return(enc)
}

# Install
# Rscript -e "install.packages('crypto', repos='http://cran.us.r-project.org')"
# Run
# Rscript encrypt.r