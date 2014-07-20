class Article < ActiveRecord::Base
  validates :title, :body, presence: true
  validates :title, uniqueness: true

  belongs_to :user

  scope :active, -> { where('published_at <= ?', Time.now).order('published_at DESC') }
end
