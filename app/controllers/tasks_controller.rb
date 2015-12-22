class TasksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @task = current_user.tasks.build(micropost_params)
    if @task.save
      flash[:success] = "task created!"
      redirect_to current_user
    else
      flash[:success] = "one of the fields is empty."
      redirect_to current_user
    end
  end

  def destroy
  end

  private

    def micropost_params
      params.require(:task).permit(:task,:location,:time)
    end
end
