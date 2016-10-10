class SessionsController < ApplicationController

  skip_before_action :ensure_login, only: [:new, :create]

  def new
  end

  def create
  	usr = User.find_by(username: params[:user][:username])
  	psw = params[:user][:password]

  	puts((usr && usr.authenticate(psw)) != false)

  	  	
  	if((usr && usr.authenticate(psw)) != false)
  		session[:user_id] = usr.id
  		redirect_to root_path, notice: "Logged in successfully"
  	else
  		redirect_to login_path, alert: "Invalid User or Password. Please try again."
  	end
  end

  def destroy
  	reset_session
  	redirect_to login_path, notice: "Logout successful."
  end
end
