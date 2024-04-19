class ApplicationController < ActionController::Base

  layout 'application'
  before_action :authenticate_user!
  # before_action :get_user_info_from_session
  # before_action :confirm_logged_in

  helper_method :breadcrumbs

  def breadcrumbs
    @breadcrumbs ||= []
  end

  def add_breadcrumb(name, path = nil)
    breadcrumbs << Breadcrumb.new(name, path)
  end

  private

  def get_user_info_from_session

    # @username = cookies[:username]
    # @user_id = session[:user_id]
  end

  def logged_in?
    # session[:user_id].present?
    # true
  end

  def confirm_logged_in
    unless logged_in?
      # flash[:alert] = "Please log in"
      # redirect_to login_path
    end
  end
end
