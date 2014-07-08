class User < ActiveRecord::Base
  before_validation :defaults

  has_many :notices
  has_many :authorizations

  validates :email, :nickname, presence: true, uniqueness: true
  validates :token, presence: true

  def salt
    authorizations.first.uid
  end

  def admin?
    email == 'phoetmail@googlemail.com'
  end

  def valid!
    update_attributes! validation_date: Time.now
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
