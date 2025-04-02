class ApplicationController < ActionController::Base
  #A09:2021 - Security Logging and Monitoring Failures. Lack of Critical Event Logging. No logging of authentication attempts, resource access, etc.
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
