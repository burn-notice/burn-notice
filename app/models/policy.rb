class Policy < ActiveRecord::Base
  BURN_NAMES = %w(burn_after_reading burn_after_time burn_after_openings)

  belongs_to :notice

  validates :name, presence: true, inclusion: { in: BURN_NAMES }

  def expired?
    created_at + setting['duration'].to_i.days < Time.now
  end

  def duration
    setting['duration']
  end

  def duration=(duration)
    setting['duration'] = duration.to_i
  end

  def amount
    setting['amount']
  end

  def amount=(amount)
    setting['amount'] = amount.to_i
  end

  def self.from_name(name: 'burn_after_reading', duration: 1, amount: 1)
    policy = new(name: name, setting: {})
    case name
    when 'burn_after_time'
      policy.duration = duration
    when 'burn_after_openings'
      policy.amount = amount
    end
    policy
  end
end
