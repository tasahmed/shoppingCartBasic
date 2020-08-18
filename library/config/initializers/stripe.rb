Rails.configuration.stripe = {
		:publisher_key => Rails.configuration.application['STRIPE_PUBLISHER_KEY'],
		:secret_key    => Rails.configuration.application['STRIPE_SECRET_KEY']
}