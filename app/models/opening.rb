class Opening < ActiveRecord::Base
  belongs_to :notice

  validate :notice, :meta, :ip, presence: true

  scope :authorized,    -> { where(authorized: true) }
  scope :unauthorized,  -> { where(authorized: false) }
end
