module Admin
  class UsersController < ApplicationController
    before_action :is_admin?
    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
    end

    def new 
      @user = User.new
    end

    def create 
      @user = User.new(user_params)
      if @user.save
        flash[:notice] = "#{@user.full_name} is created!"
        redirect_to admin_users_path
      else
        render :new
      end
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        flash[:notice] = "#{@user.full_name} profile is updated successfully"
        redirect_to admin_users_path
      else
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      UserMailer.account_deleted_email(@user).deliver_now
      flash[:notice] = "#{@user.full_name} deleted!"
      redirect_to admin_users_path
    end

    private

    def is_admin?
      unless current_user && current_user.is_admin
        flash[:alert] = "unauthorized access denied!"
        redirect_to home_path 
      end
    end

    def user_params
      params.require(:user).permit(:email, :firstname, :lastname, :is_admin, :password, :password_confirmation)
    end

  end
end