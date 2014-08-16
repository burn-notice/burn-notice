class Notice < ActiveRecord::Base
  include Crypto
  before_validation :defaults, :store_encrypted

  attr_accessor :answer, :content, :share_type, :share_recipients

  belongs_to :user
  has_one :policy, dependent: :destroy
  has_many :openings, dependent: :destroy

  accepts_nested_attributes_for :policy

  validates :token, :question, presence: :true
  validates :answer, :content, presence: :true, if: Proc.new { |notice| notice.data.blank? }

  enum status: {draft: 0, open: 1, read: 2, closed: 3}

  def valid_secret?(secret)
    read_data(secret).present?
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
    self.token = SecureRandom.hex(16) if new_record?
  end

  def store_encrypted
    write_data(content, answer) if content.present? && answer.present?
  end

  class << self
    def from_param(token)
      find_by_token!(token)
    end
  end
end
