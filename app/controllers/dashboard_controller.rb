class DashboardController < ApplicationController
  # A01:2021 - Broken Access Control: allows access to other users' data via ID
  def index
    @user = User.find(params[:user_id] || current_user.id)
    @articles = @user.articles
  end
end