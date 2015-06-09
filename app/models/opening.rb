class Opening < ActiveRecord::Base
  belongs_to :notice

  validates :notice, :meta, :ip, presence: true

  enum authorization: {requested: 0, authorized: 1, unauthorized: 2}
end
