class BetaUser < ActiveRecord::Base
  before_validation :defaults

  validates :email, uniqueness: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  def to_param
    token
  end

  private

  def defaults
    self.token = SecureRandom.hex(16) if token.nil?
  end

  class << self
    def from_param(token)
      find_by_token!(token)
    end
  end
end
