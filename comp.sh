# compare php, python and java output and return 0 if they are the same and 1 if they are different
# $1: php command
# $2: java command

# CD to java directory
cd java

# check if encrypt.class exists
if [ ! -f encrypt.class ]; then
    echo "encrypt.class does not exist"
    # run javac to compile encrypt.java
    javac encrypt.java
fi

# run java encrypt
java encrypt > java_output.txt

# CD to php directory
cd ../php

# run php encrypt
php encrypt.php > php_output.txt

# CD to python directory
cd ../python

# run python encrypt
python3 encrypt.py > python_output.txt

# CD to project directory
cd ..

# DB

# Read php_output.txt, java_output.txt and python_output.txt
php_output=$(cat php/php_output.txt)
java_output=$(cat java/java_output.txt)
python_output=$(cat python/python_output.txt)

# Compare php_output, java_output and python_output
if [ "$php_output" == "$java_output" ] && [ "$php_output" == "$python_output" ]; then
    echo "PHP, Java and Python output are the same"
    exit 0
else
    # Compare php_output and java_output
    if [ "$php_output" == "$java_output" ]; then
        echo "PHP and Java output are the same"
    else
        echo "PHP and Java output are different"
    fi
    # Compare php_output and python_output
    if [ "$php_output" == "$python_output" ]; then
        echo "PHP and Python output are the same"
    else
        echo "PHP and Python output are different"
    fi
    # Compare java_output and python_output
    if [ "$java_output" == "$python_output" ]; then
        echo "Java and Python output are the same"
    else
        echo "Java and Python output are different"
    fi
    exit 1
fi