class ApplicationController < ActionController::Base

	before_action :authorized
	helper_method :current_user
	helper_method :logged_in?


	def current_user    
    	User.find_by(id: session[:user_id])  
	end

	def logged_in?
		!current_user.nil?
	end

	def authorized
		redirect_to '/welcome' unless logged_in?
	end

	#function to generate randome code with number of alphanumeric character count in parameters
	def generate_activation_code(size = 6)
	  charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
	  (0...size).map{ charset.to_a[rand(charset.size)] }.join
	end
end
