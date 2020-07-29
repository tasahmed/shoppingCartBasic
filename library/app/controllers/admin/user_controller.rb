class Admin::UserController < ApplicationController

	#layout "admin", only: [:adminList]
	layout "admin"

	before_action :set_user, only: [:edit, :destroy, :update]

	def list
		#pass this value to get the table header
		@columns = Array["name", "email", "user_type", "created_at"]
		#pass this value to get the table rows
		@rows    = User.select("name, email, user_type, created_at", "id")
		#pass edit and delete routes to view to display in @curd variable
		@curd    = Array('Edit' => '/admin/user/edit', 'Delete' => '/admin/user/delete')

	end

	def new
  		@user = User.new
  end

	def create
		
		@randomCode = generate_activation_code(10)
		
		#logger.debug "User Params#{params.to_json}"
		#logger.debug "RandomPassword#{@randomCode}"
   	 	# @user = User.new do |u|
   	 	# 	u.name  	 	 = params[:user][:name]
   	 	# 	u.email 	 	 = params[:user][:email]
   	 	# 	u.user_type  = params[:user_type]
   	 	# 	u.password   = @randomCode
   	 	# 	u.created_at = DateTime.now 
   	 	# end

   	 	#if @user.save

   	 	##add params for the random password field
   	 	params[:user][:password] = @randomCode

   	 	@user = User.new(params.require(:user).permit(:name, :email, :user_type, :password))
	   	
	   	if @user.save
	   	 	#trigger to send mail
	   	 	#UserregistrationMailer.userregistration_email(@user, @randomCode).deliver
	   	 	#commented since this is local system
	   	 	#SendEmailJob.set(wait: 20.seconds).perform_later(@user, @randomCode)
	   	 	@message 	  = 'User was successfully created'
	   	 	@alert_type = 'success'
	   	 	redirect_to '/admin/user/list', flash: { @alert_type => @message}
	   	else
	   		@message 	  = @user.errors.full_messages
	   		@alert_type = 'danger'
	   		redirect_to '/admin/user/new',  flash: { @alert_type => @message.to_a}
	   	end
	end

  def edit

	end

	def destroy
		
		@user.destroy
		redirect_to '/admin/user/list', flash: { 'success' => 'User deleted successfully'}
	end

	def update
		
		if @user.update(params.require(:user).permit(:name, :user_type))
			@message 	  = 'User was successfully updated'
	   	@alert_type = 'success'
	   	redirect_to '/admin/user/list', flash: { @alert_type => @message}
		else
			@message 	  = @user.errors.full_messages
	   	@alert_type = 'danger'
	   	redirect_to '/admin/user/edit',  flash: { @alert_type => @message.to_a}
		end
	end

	private

	def set_user
			@user = User.find(params[:id])
	end
end