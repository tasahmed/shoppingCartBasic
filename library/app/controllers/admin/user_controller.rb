class Admin::UserController < ApplicationController

	#layout "admin", only: [:adminList]
	layout "admin"

	def list
		# TO DO ORDER recordset colummns as per requirement
		#pass this value to get the table header
		@columns = User.select("name, email, user_type, created_at").first
		#pass this value to get the table rows
		@rows    = User.select("name, email, user_type, created_at")
	end

	def new
  		@user = User.new
  	end

  	def generate_activation_code(size = 6)
	  charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
	  (0...size).map{ charset.to_a[rand(charset.size)] }.join
	end

	def create
		logger.debug "User Params#{params.to_json}"
		@user = User.create(params.require(:user).permit(:name, :email, :user_type))
   	 	#session[:user_id] = @user.id
   	 	redirect_to '/admin/user/list'
	end
	
end