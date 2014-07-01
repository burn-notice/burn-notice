generate public and private keys and put them here:

openssl genrsa -des3 -out private_production.pem 2048
openssl rsa -in private_production.pem -out public_production.pem -outform PEM -pubout

http://stuff-things.net/2008/02/05/encrypting-lots-of-sensitive-data-with-ruby-on-rails/
