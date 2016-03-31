class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to movies_path, notice: "Welcome back, #{user.firstname}!"
    else
      flash.now[:alert] = "email and password combination is not correct"
      render :new

    end
  end

  def switch_to_user
    if current_user && current_user.is_admin
      session[:admin_user_id] = current_user.id
      session[:user_id] = params[:id]
      redirect_to home_path
    else
      render html: 'not authorized'
    end
  end

  def switch_to_admin
    if current_user
      if session[:admin_user_id]
        session[:user_id] = session[:admin_user_id]
        session[:admin_user_id] = nil
      end
      redirect_to home_path
    else
      render html: 'not authorized'
    end
  end


  def destroy
    session[:user_id] = nil
    session[:admin_user_id] = nil
    redirect_to movies_path, notice: "Adios!"
  end
end
