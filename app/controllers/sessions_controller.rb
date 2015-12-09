class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      render js: "window.location='#{user_path(user)}'"
    else
       respond_to do |format|
        if user
          flash.now[:danger] = 'Invalid password'
        else
          flash.now[:danger] = 'Invalid email/password combination' 
        end  
        format.html {render partial: 'new'}
        format.js 
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
