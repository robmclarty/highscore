class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def categories
    @categories ||= Category.order(:name)
  end
  helper_method :categories

  def page_not_found
    redirect_to '/404.html'
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def require_login
    unless current_user
      flash.now.alert = "You are not authorized to view this page!"
      render :template => 'sessions/new'
    end
  end
end
