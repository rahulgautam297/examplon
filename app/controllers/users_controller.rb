class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Examplon!"
      render js: "window.location='#{user_path(@user)}'"
    else
      respond_to do |format|
        format.html {render '_new' }
        format.js
      end
    end
  end
  
   private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
