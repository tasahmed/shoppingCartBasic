class UserController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]

  def new
  	@user = User.new
  	#logger.debug "User object #{@user.to_json}"
  end

  def create

    @randomCode = generate_activation_code(10)

    params[:user][:user_type] = 1;
    
    @user = User.create(params.require(:user).permit(:name, :email, :user_type, :password))
    logger.debug "Error in saving user #{@user.errors.full_messages}"
   	session[:user_id] = @user.id
    redirect_to '/product/list'
  end
  
end