class User < ActiveRecord::Base
  before_validation :defaults

  has_many :notices, -> { active.order('created_at DESC') }, dependent: :destroy
  has_many :authorizations, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :sender_connections, dependent: :destroy, class_name: "GoogleAuthConnection", foreign_key: 'sender_id', inverse_of: :sender
  has_many :recipient_connections, dependent: :destroy, class_name: "GoogleAuthConnection", foreign_key: 'recipient_id', inverse_of: :recipient

  accepts_nested_attributes_for :authorizations

  validates :email, :token, presence: true, uniqueness: true

  def salt
    authorizations.first.uid
  end

  def admin?
    email.in? ['phoetmail@googlemail.com', 'me@kurtfunai.com']
  end

  def validate!
    update_attributes! validation_date: Time.now
  end

  def validated?
    validation_date.present?
  end

  def accepted_connections
    if validated?
      recipient_connections.active
    else
      []
    end
  end

  def pending_connections
    if validated?
      GoogleAuthConnection.active.where(email: email, recipient: nil)
    else
      []
    end
  end

  private

  def defaults
    if new_record?
      self.token = SecureRandom.hex(16)
    end
  end

  class << self
    def handle_authorization(auth)
      provider = auth['provider']
      uid      = auth['uid']

      authorization = Authorization.find_or_initialize_by(provider: provider, uid: uid)

      return authorization.user if authorization.user

      user = User.create!(nickname: auth['info']['nickname'], email: auth['info']['email'])
      Authorization.create!(user: user, provider: provider, uid: uid)
      user
    end

    def authenticated_with_token(id, stored_salt)
      user = find_by_id(id)
      user && user.salt == stored_salt ? user : nil
    end

    def find_by_session_or_cookies(session, cookies)
      find_by_id(session[:user_id]) || authenticated_with_token(*(cookies.signed[:remember_me] || ['', '']))
    end
  end
end
