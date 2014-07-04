class Notice < ActiveRecord::Base
  include Crypto

  belongs_to :user
  has_one :policy
  has_many :openings

  validates :user, :policy, :data, presence: :true

  def data
    if hash = read_attribute(:data)
      decrypt hash.symbolize_keys
    else
      nil
    end
  end

  def data=(text)
    write_attribute :data, encrypt(text)
  end
end
