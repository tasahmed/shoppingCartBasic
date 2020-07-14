class UserController < ApplicationController
  
  skip_before_action :authorized, only: [:new, :create]

  def new
  	@user = User.new
  	#logger.debug "User object #{@user.to_json}"
  end

  def create
  	 @user = User.create(params.require(:user).permit(:name, :password, :email))
   	 session[:user_id] = @user.id
   	 redirect_to '/product/list'
  end
end