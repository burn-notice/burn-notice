class Policy < ActiveRecord::Base
  BURN_NAMES = %w(burn_after_reading burn_after_time burn_after_openings)

  attr_accessor :interval

  belongs_to :notice

  validates :name, presence: true, inclusion: { in: BURN_NAMES }

  def self.from_name(name: 'burn_after_reading', interval: 1)
    policy = new(name: name)
    case name
    when 'burn_after_time'
      policy.setting = {duration: interval}
    when 'burn_after_openings'
      policy.setting = {count: interval}
    end
    policy
  end
end
