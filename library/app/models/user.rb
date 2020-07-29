class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_secure_password
	has_many :order
	
	validates :name, :email, presence: true, length: {minimum: 6, maximum: 50}
	validates :email, uniqueness: true, length: {minimum: 10, maximum: 300}
	
	enum userStatus: { inactive: 0, active: 1 }
	enum userType: { admim: 0, normal: 1, buyer: 2 }

end