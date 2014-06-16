class User < ActiveRecord::Base
  has_many :notices
end
