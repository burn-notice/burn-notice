class Notice < ActiveRecord::Base
  include Crypto

  belongs_to :user
  has_one :policy
  has_many :openings

  validates :user, :policy, :data, presence: :true

  def data
    decrypt read_attribute(:data).symbolize_keys
  end

  def data=(text)
    write_attribute :data, encrypt(text)
  end
end
