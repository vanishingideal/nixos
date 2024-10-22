function encrypt
    openssl aes-256-cbc -pbkdf2 -salt -in $argv[1] -out $argv[2] -pass "pass:$argv[3]"
end

function decrypt
    openssl aes-256-cbc -pbkdf2 -salt -d -in $argv[1] -out $argv[2] -pass "pass:$argv[3]"
end

