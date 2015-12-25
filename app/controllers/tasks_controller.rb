class TasksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "task created!"
      redirect_to current_user
    elsif (@task.location.blank?)
      @task.location = request.location.city
      @task.save
      flash[:success] = "task created!"
      redirect_to current_user
    else
      flash[:danger] = "Task field is empty or you didn't turn on GPS."
      redirect_to current_user
    end
  end

  def destroy
  end

  private

    def task_params
      params.require(:task).permit(:task,:location,:time)
    end
end
