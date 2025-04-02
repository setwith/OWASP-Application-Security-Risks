class SessionsController < ApplicationController
  def new
  end
  
  # A02:2021 - Cryptographic Failures. User search without password hashing
  def create
    user = User.find_by(username: params[:username], password: params[:password])
    
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Ви успішно увійшли!'
    else
      flash.now[:alert] = 'Невірний логін або пароль'
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Ви вийшли з системи'
  end
end