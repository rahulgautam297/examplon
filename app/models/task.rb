class Task < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :task, presence: true
  validates :location, presence: true
  validates :time, presence: true
end
