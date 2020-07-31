require 'elasticsearch/model'

class Product < ApplicationRecord

	has_many   :variants
	has_many   :orders
	belongs_to :category

	validates :name, presence: true, length: {minimum: 6, maximum: 50}
	validates :description, presence: true, length: {minimum: 6, maximum: 300}
	validates :image_url, presence: true
	validates :price, presence: true,numericality: { only_integer: true }
	validates :quantity, presence: true, numericality: { only_integer: true }

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

	def image_size_validation
    #errors[:image_url] << "File field should not be empty" if image_url.present?
    if image_url.present?
      errors.add(:image_url, "must be present") unless image_url.present?
    end
  end

end