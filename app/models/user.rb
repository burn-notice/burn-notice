class User < ActiveRecord::Base
  has_many :notices

  validates :email, :nickname, presence: true
end
