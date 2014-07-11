class Policy < ActiveRecord::Base
  BURN_TYPES = %w(burn_after_reading burn_after_time burn_after_openings)
  belongs_to :notice

  validates :name, presence: true, inclusion: { in: BURN_TYPES }

  def self.from_type(type, options = {})
    policy = new(name: type)
    case type
    when 'burn_after_time'
      policy.setting = options.slice(:duration)
    when 'burn_after_openings'
      policy.setting = options.slice(:count)
    end
    policy
  end
end
