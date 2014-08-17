require 'openssl'
require 'base64'

# stolen from http://stuff-things.net/2008/02/05/encrypting-lots-of-sensitive-data-with-ruby-on-rails/
module Crypto
  CRYPT_256_BIT_AES_CBC = 'aes-256-cbc'
  TEST_PASSWORD = 'xxxxxx'

  def encrypt(data, secret)
    cipher = OpenSSL::Cipher::Cipher.new(CRYPT_256_BIT_AES_CBC)
    cipher.encrypt
    cipher.key  = key = cipher.random_key
    cipher.iv   = simple_digest(secret)

    encrypted_data = cipher.update(data)
    encrypted_data << cipher.final

    encrypted_key = public_key.public_encrypt(key)

    {
      encrypted_data: encode(encrypted_data),
      encrypted_key: encode(encrypted_key),
      fingerprint: digest(data)
    }
  end

  def decrypt(data, secret)
    cipher = OpenSSL::Cipher::Cipher.new(CRYPT_256_BIT_AES_CBC)
    cipher.decrypt
    cipher.key  = private_key.private_decrypt(decode(data[:encrypted_key]))
    cipher.iv   = simple_digest(secret)

    decrypted_data = cipher.update(decode(data[:encrypted_data]))
    decrypted_data << cipher.final
    if data[:fingerprint] == digest(decrypted_data)
      decrypted_data
    else
      nil
    end
  rescue OpenSSL::Cipher::CipherError
    nil
  end

  private

  def public_key
    @public_key ||= begin
      content = ENV['PUBLIC_KEY'] || File.read(Rails.root.join("config/keys/public_#{Rails.env}.pem"))
      OpenSSL::PKey::RSA.new(content)
    end
  end

  def private_key
    @private_key ||= begin
      content = ENV['PRIVATE_KEY'] || File.read(Rails.root.join("config/keys/private_#{Rails.env}.pem"))
      OpenSSL::PKey::RSA.new(content, key_password)
    end
  end

  def simple_digest(text)
    digest(text.gsub(/\s/, '').downcase)
  end

  def digest(text)
    Digest::SHA256.new.hexdigest(text)
  end

  def encode(text)
    Base64.encode64(text)
  end

  def decode(text)
    Base64.decode64(text)
  end

  def key_password
    ENV['PASSWORD'] || TEST_PASSWORD
  end
end
