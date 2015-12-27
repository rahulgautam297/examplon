class TaskWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  def perform(input)
    task=Task.find_by(id: input)
    TaskMailer.notifier(task).deliver_now
  end
end