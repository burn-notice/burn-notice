class Opening < ActiveRecord::Base
  belongs_to :notice

  validate :notice, :meta, :ip, presence: true
end
