class ControlTasksController < ApplicationController
    
    def edit
        
      task = Task.find_by(id: params[:id])
      if !task.nil?
        user= task.user
        if params[:delete]
          if user && user.activated?
            task.destroy
            log_in user
            flash[:info] = "task deleted."
            redirect_to user
          else
            flash[:danger] = "Invalid Access."
            redirect_to root_url
          end
        else
          if user && user.activated?
            log_in user
            task.time+= 2.hours
            task.save
            user.create_edittask_digest
            user.create_deletetask_digest
            task.send_task_control_email
            flash[:success] = "Time updated by 2 hours. Mail will be delivered half an hour before the scheduled time."
            redirect_to user
          else
            flash[:danger] = "Invalid Access."
            redirect_to root_url
          end
        end
      else
        flash[:danger] = "Task not found."
        redirect_to root_url
      end
    end
    
end
