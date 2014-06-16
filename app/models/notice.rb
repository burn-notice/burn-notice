class Notice < ActiveRecord::Base
  belongs_to :user
  has_one :policy
  has_many :openings
end
