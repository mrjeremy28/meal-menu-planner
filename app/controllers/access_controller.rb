class AccessController < ApplicationController

  # before_action :get_user_info_from_session, only: [:menu, :new]
  # skip_before_action :confirm_logged_in, only: [:new, :create]

  # display menu here
  def menu
  end

  # display login form
  def new
    if logged_in?
      # redirect_to(menu_path)
    end
  end

  # process login form
  def create
    logger.info("*** Login User #{params[:username]}")
    # cookies[:username] = params[:username]
    # session[:user_id] = 1483
    # flash[:notice] = "Log in successful"
    # # do login process here
    # redirect_to(menu_path)
  end

  def destroy
    # session[:user_id] = nil
    # logger.info("*** Log Out User #{cookies[:username]}")
    # cookies[:username] = nil
    # flash[:notice] = "Logged out"
    # redirect_to(login_path)
  end


end
