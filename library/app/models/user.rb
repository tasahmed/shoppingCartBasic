class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_secure_password
	has_many :order
	
	validates :name, presence: true, length: {minimum: 4, maximum: 50}
	#validate :name, :email, presence: true
	validates :email, uniqueness: true, length: {minimum: 10, maximum: 300}
	validates :password, presence: true
	
	enum user_status: { inactive: 0, active: 1 }
	enum user_type: { admin: 0, normal: 1, buyer: 2 }

end