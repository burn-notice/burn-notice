class Notice < ActiveRecord::Base
  include Crypto

  belongs_to :user
  has_one :policy
  has_many :openings

  validates :user, :policy, :data, presence: :true

  def valid_secret?(secret)
    !!read_data(secret)
  rescue OpenSSL::Cipher::CipherError
    false
  end

  def read_data(secret)
    if hash = read_attribute(:data)
      decrypt(hash.symbolize_keys, secret)
    else
      nil
    end
  end

  def write_data(text, secret)
    hash = encrypt(text, secret)
    write_attribute(:data, hash)
  end
end
