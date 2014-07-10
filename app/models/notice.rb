class Notice < ActiveRecord::Base
  include Crypto
  before_validation :defaults

  belongs_to :user
  has_one :policy
  has_many :openings

  validates :user, :policy, :data, :token, presence: :true

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

  def to_param
    token
  end

  def authorized
    return unless openings.present?
    openings.any?(&:authorized?)
  end

  private

  def defaults
    if new_record?
      self.token = SecureRandom.hex(16)
    end
  end

  class << self
    def from_param(token)
      find_by_token(token)
    end
  end
end
