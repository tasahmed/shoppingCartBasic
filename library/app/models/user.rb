class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	has_secure_password
	has_many :order
	#validate_presence_of :name,
	#enum userStatus : {0:inactive, 1:active},
	#enum userType : {0:buyer, 1:seller, 2:admin}
end