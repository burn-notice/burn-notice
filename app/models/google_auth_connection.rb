class GoogleAuthConnection < ActiveRecord::Base
  before_validation :defaults

  enum status: {active: 0, disabled: 1, deleted: 2}

  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id', inverse_of: :sender_connections
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id', inverse_of: :recipient_connections

  validates :token, :email, presence: true
  validates :token, uniqueness: true
  validates :email, uniqueness: {scope: :sender_id}

  private

  def defaults
    if new_record?
      self.token = SecureRandom.hex(16)
    end
  end
end
