class Notice < ActiveRecord::Base
  include Crypto

  belongs_to :user
  has_one :policy
  has_many :openings

  validates :user, :policy, :data, presence: :true

  def read_data(pasword)
    if hash = read_attribute(:data)
      decrypt(hash.symbolize_keys, password)
    else
      nil
    end
  end

  def write_data(text, password)
    hash = encrypt(text, password)
    write_attribute(:data, hash)
  end
end
