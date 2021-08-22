class SessionsController < ApplicationController

  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
    if session[:user_id]
      redirect_to '/product/list'
    end
  end

  def create

    if (params[:username] == '' || params[:password] == '')
       redirect_to '/login', flash: { 'danger' => 'Username & password cannot be empty!'}
       return
    end

	   @user = User.find_by(name: params[:username])
	   #@user = User.new
     if @user && @user.authenticate(params[:password])

        #set session variables
        session[:user_id]   = @user.id
        session[:user_type] = @user.user_type
        session[:email]     = @user.email
        logger.debug "UserType #{@user.user_type}"
        ##user_type 1 = admin
        if @user.user_type == 'admin'
	       redirect_to '/admin/user/list'
        ## other user_types are treated as normal users for now
        else
         redirect_to '/product/list'
        end
	   
     else
        #logger.debug "else condition1 #{@user.to_json}"
        #logger.debug "else condition2 #{@user.authenticate(params[:password])}"
        #@user.errors.full_messages
	      redirect_to '/login', flash: { 'danger' => 'Wrong username and password, please try again!'}
	   end
  end

  def page_requires_login
  end

  def check

  end

  def destroy
    session[:user_id] = session[:user_type] =  session[:email] = nil
    #flash[:message]   = "User logged out Successfully!"
    redirect_to '/welcome'
  end

  #def welcome
  #end
end
