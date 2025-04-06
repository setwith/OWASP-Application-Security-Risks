class SessionsController < ApplicationController
  def new
  end
  
  # A02:2021 - Cryptographic Failures. User search without password hashing
  # A07:2021 - Identification and Authentication Failures. No login attempt limit
  def create
    user = User.find_by(username: params[:username], password: params[:password])
    
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Successfully logged in!'
    else
      flash.now[:alert] = 'Invalid credentials'
      render :new
    end
  end

  def forgot_password
  end
  
  def reset_password
    username = params[:username]
    security_answer = params[:security_question]
  
    user = User.find_by(username: username)
  
    if user
      new_password = "reset123"
      user.update(password: new_password)
      redirect_to login_path, notice: "Your password has been reset to: #{new_password}"
    else
      flash.now[:alert] = "User not found"
      render :forgot_password
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Successfully logged out!'
  end
end