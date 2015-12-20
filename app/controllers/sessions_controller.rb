class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        if session[:forwarding_url].nil?
          render js: "window.location='#{user_path(user)}'"
        else
          render js: "window.location='#{session[:forwarding_url]}'"
          session.delete(:forwarding_url)
        end
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        render js: "window.location='#{root_url}'"
      end
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
