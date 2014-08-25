class Opening < ActiveRecord::Base
  belongs_to :notice

  validate :notice, :meta, :ip, presence: true

  enum authorization: {requested: 0, authorized: 1, unauthorized: 2}
end
