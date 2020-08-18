class Payment < ApplicationRecord

	attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year
	has_many :order

	def self.month_options
		Date::MONTHNAMES.compact.each_with_index.map { |name, i| ["#{i+1} - #{name}", i+1]}
	end

	def self.year_options
		(Date.today.year..(Date.today.year+10)).to_a
	end

	def process_payment(amount_to_pay, desc)

		#convert to the smallest unit of currents ex. paise for INR
		amount_to_pay_units = (amount_to_pay.to_i * 100) 

		Stripe.api_key = Rails.configuration.application['STRIPE_SECRET_KEY']
		customer = Stripe::Customer.create email: email, card: token
		charge = Stripe::Charge.create ({ 
			customer: customer.id,
			amount: amount_to_pay_units,
			description: desc,
			currency: 'inr'
		})
		#logger.debug "charge #{charge}"


	end
end
