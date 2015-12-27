class Task < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :task, presence: true
  validates :time, presence: true
  geocoded_by :location 
  reverse_geocoded_by :latitude, :longitude, :address => :location 
  after_validation :geocode, :reverse_geocode
  
  def send_task_control_email
    if self.time-30.minutes < Time.zone.now
      TaskMailer.notifier(self).deliver_now
    else
      TaskWorker.perform_at(self.time-30.minutes, self.id)
    end
  end
end
