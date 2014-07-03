class Policy < ActiveRecord::Base
  belongs_to :notice

  validates :name, :setting, presence: true
end
