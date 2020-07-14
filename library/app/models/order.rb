class Order < ApplicationRecord
	has_one :user
	has_one :product
	has_one :payment
end
