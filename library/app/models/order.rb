class Order < ApplicationRecord
	has_one :user
	has_one :product
	has_one :payment
	accepts_nested_attributes_for :payment
end
