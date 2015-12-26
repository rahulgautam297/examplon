class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def index
 @users = User.where(activated: true).paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.paginate(page: params[:page])
    @task = current_user.tasks.build if logged_in?
    @hash = Gmaps4rails.build_markers(@tasks) do |task, marker|
      if (!task.latitude.blank? && !task.longitude.blank? )
      marker.lat        task.latitude
      marker.lng        task.longitude
      marker.infowindow task.task
    else
      marker.lat        request.location.latitude
      marker.lng        request.location.longitude
      marker.infowindow task.task
      end
    end
    redirect_to root_url and return unless @user.activated?
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      respond_to do |format|
        format.html {redirect_to root_url}
        format.js {render js: "window.location='#{root_url}'"}
      end
    else
      respond_to do |format|
        format.html {redirect_to root_url}
        format.js
      end
    end
  end
  
  def edit
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
   private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
      
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to root_url
      end
    end
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
