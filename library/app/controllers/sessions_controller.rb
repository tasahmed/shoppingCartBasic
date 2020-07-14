class SessionsController < ApplicationController

  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
    if session[:user_id]
      redirect_to '/product/list'
    end
  end

  def create

	   @user = User.find_by(name: params[:username])
	   
     if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
	      redirect_to '/product/list'
	   else
        #logger.debug "else condition1 #{@user.to_json}"
        #logger.debug "else condition2 #{@user.authenticate(params[:password])}"
	      redirect_to '/login'
	   end
  end

  def page_requires_login
  end

  def check

  end

  #def welcome
  #end
end
