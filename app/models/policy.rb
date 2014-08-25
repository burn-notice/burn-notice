class Policy < ActiveRecord::Base
  BURN_NAMES = %w(burn_after_reading burn_after_time burn_after_openings)

  attr_accessor :duration, :amount

  belongs_to :notice

  validates :name, presence: true, inclusion: { in: BURN_NAMES }

  def expired?
    created_at + setting['duration'].to_i.days < Time.now
  end

  def self.from_name(name: 'burn_after_reading', duration: 1, amount: 1)
    policy = new(name: name)
    case name
    when 'burn_after_time'
      policy.setting = {duration: duration}
    when 'burn_after_openings'
      policy.setting = {amount: amount}
    end
    policy
  end
end
