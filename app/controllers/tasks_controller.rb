class TasksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      if @task.location.empty?
        @task.location=request.location.city
        @task.save
      end
      @user=current_user
      @user.create_edittask_digest
      @user.create_deletetask_digest
      @task.send_task_control_email
      flash[:success] = " Task created.Mail will be delivered half an hour before the scheduled time."
    redirect_to current_user
    else
      flash[:danger] = "Task field is empty"
      redirect_to current_user
    end
  end

  def destroy
  end

  private

    def task_params
      params.require(:task).permit(:task,:location,:time,:longitude,:latitude)
    end
end
