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

        #set session variables
        session[:user_id]   = @user.id
        session[:user_type] = @user.user_type

        ##user_type 1 = admin
        if @user.user_type == 1
	       redirect_to '/admin/user/list'
        ## other user_types are treated as normal users for now
        else
         redirect_to '/product/list'
        end
	   
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

  def destroy
    session[:user_id] = session[:user_type] = nil
    #flash[:message]   = "User logged out Successfully!"
    redirect_to '/welcome'
  end

  #def welcome
  #end
end
