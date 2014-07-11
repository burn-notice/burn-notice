class Notice < ActiveRecord::Base
  include Crypto
  before_validation :defaults

  attr_accessor :password, :content

  belongs_to :user
  has_one :policy, dependent: :destroy
  has_many :openings, dependent: :destroy

  accepts_nested_attributes_for :openings, :policy

  validates :user, :data, :token, presence: :true

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

  def policy
    read_attribute(:policy) || Policy.from_type('burn_after_reading')
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
