class TasksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "task created!"
      redirect_to current_user
    else
      flash[:danger] = "one of the fields is empty."
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
