class Notice < ActiveRecord::Base
  DEFAULT_NUMBER_OF_UNAUTHORIZED_ATTEMPTS = 3

  include Crypto
  before_validation :defaults, :store_encrypted

  attr_accessor :answer, :content, :share_recipients

  belongs_to :user
  has_one :policy, dependent: :destroy
  has_many :openings, dependent: :destroy

  accepts_nested_attributes_for :policy

  validates :token, :question, :policy, presence: :true
  validates :answer, :content, presence: :true, if: Proc.new { |notice| notice.data.blank? && notice.open? }

  enum status: {open: 0, disabled: 1, closed: 2, deleted: 3}

  scope :active, -> { where("status <> ?", Notice.statuses[:deleted]) }
  scope :expired, -> { active.where('notices.updated_at < ?', 1.day.ago).joins(:policy).where('policies.name = ?', 'burn_after_time') }

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

  def apply_policy(authorized:)
    if authorized
      case policy.name
      when "burn_after_reading"
        burn!
      when "burn_after_time"
        if policy.expired?
          burn!
        end
      when "burn_after_openings"
        if openings.authorized.count >= policy.amount.to_i
          burn!
        end
      end
    else
      if openings.reject { |opening| opening.authorized? }.size % DEFAULT_NUMBER_OF_UNAUTHORIZED_ATTEMPTS == 0
        update! status: :disabled
      end
    end
  end

  def burn!
    self.status = :closed
    self.data = {}
    save(validate: false)
  end

  def authorized
    return unless openings.present?
    openings.any?(&:authorized?)
  end

  def to_param
    token
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
      active.find_by_token!(token)
    end

    def burn_expired
      expired.each do |notice|
        if notice.policy.expired?
          Rails.logger.info("notice #{notice.id} is expired, burning")
          notice.burn!
        else
          Rails.logger.info("notice #{notice.id} is not yet expired")
        end
      end
    end
  end
end
