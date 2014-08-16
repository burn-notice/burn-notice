class Policy < ActiveRecord::Base
  BURN_TYPES = %w(burn_after_reading burn_after_time burn_after_openings)

  attr_accessor :interval

  belongs_to :notice

  validates :name, presence: true, inclusion: { in: BURN_TYPES }

  def self.from_type(type = nil, interval: nil)
    interval ||= 1

    policy = new(name: type)
    case type
    when 'burn_after_time'
      policy.setting = {duration: interval}
    when 'burn_after_openings'
      policy.setting = {count: interval}
    end
    policy
  end
end
