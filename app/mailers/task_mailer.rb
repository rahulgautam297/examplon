class TaskMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.task_mailer.notifier.subject
  #
  def notifier(task)
    @task= task
    mail to: @task.user.email, subject: "Task- #{@task.task}"
  end
end
