require 'elasticsearch/model'

class Product < ApplicationRecord

	has_many :variants
	has_many :orders
	belongs_to :category

	enum status: { pending: 0, failed: 1, paid: 2, paypal_executed: 3}

	include Searchable

	def set_paid
	    self.status = Order.statuses[:paid]
	end
	
	def set_failed
	    self.status = Order.statuses[:failed]
	end
	
	def set_paypal_executed
		self.status = Order.statuses[:paypal_executed]
	end

end