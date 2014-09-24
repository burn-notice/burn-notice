require 'uri'
require 'base32'
require 'openssl'
require 'securerandom'

class Authenticator

  attr_accessor :secret_key, :date

  def initialize(secret_key, date = Time.now)
    @secret_key = Base32.encode(secret_key)
    @date = date
  end

  def qrcode_image_url(label, wh = 250)
    otpauth = URI.escape("otpauth://totp/#{label}?secret=#{@secret_key}")
    "https://chart.googleapis.com/chart?chs=#{wh}x#{wh}&cht=qr&choe=UTF-8&chl=#{otpauth}"
  end

  def key_valid?(key)
    get_keys.include?(key.to_i)
  end

  def get_keys
    span = @date.to_i / 30.seconds
    key = Base32.decode(@secret_key)
    sha = OpenSSL::Digest.new('sha1')

    [-1, 0, 1].map do |x|
      bytes = [span + x].pack('>q').reverse
      hmac = OpenSSL::HMAC.digest(sha, key.to_s, bytes)
      offset = hmac[-1].ord & 0x0F
      hash = hmac[offset...offset + 4]

      code = hash.reverse.unpack('L')[0]
      code &= 0x7FFFFFFF
      code %= 1000000
      code
    end
  end
end
