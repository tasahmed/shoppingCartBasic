class ProductController < ApplicationController
	
	layout 'standards'

	#include InitializePaymentPaypal

	### function to list all products in list page based on added date
	def list
		@categories = Category.all
		@products   = Product.order("created_date DESC").paginate(page: params[:page], per_page: 10)
	end

	def show
		@product 		= Product.find(params[:id])
		@categories = Category.all
	end	

#	def search
		#logger.debug "{#params[:search_name]}"
#		if params[:search_val]
			##provide required values to display template
#			@categories   = Category.all
			##User.where('first_name LIKE :first_name', first_name: "%#{first_name}%") 
			#@products     = Product.where('name LIKE :search_name', search_name: "%#{params[:search_val]}%")
			#@products   = Product.all
			#logger.debug "#{@products.inspect}"
#			@responseCode = true;
#			@html 		  = render_to_string(:partial => 'product/list', :locals => {:products => @products})
#		else
#			@responseCode = false;
#		end

 # 		render json: { success: @responseCode, html_content: @html }
#	end

	def search

		##return categoriesi for template display
		@categories   = Category.all
		
		if params[:search_val]
			results = Product.search(params[:search_val], search_params)

			logger.debug "Raw Products JSON output: #{results.to_json}"
			@products = results.map do |r|
				r.merge(r.delete('_source')).merge('id': r.delete('_id')).without('_index','_type', '_id', '_score')
			end

			#@products   = Product.all

			logger.debug "Products JSON output: #{@products.to_json}"

			@responseCode = true;
			@html 		  = render_to_string(:partial => 'product/list', :locals => {:products => @products})

			#render json: { products: @products, status: 'ok' }
		else
			@responseCode = false;
		end
			
		render json: { success: @responseCode, html_content: @html }
	end

	def calculateValue

		if params[:productQuantity] and params[:productId]
			logger.debug "productQuantity:#{params[:productQuantity]}---productId:#{params[:productId]}"
			#get produts single quantity price from table
			@product   				 = Product.find(params[:productId])
			productSum 			   = (@product.price * Integer(params[:productQuantity]))
			totalValue 				 = "Rs. #{productSum}"
		
			logger.debug "Product Sum#{productSum}"

			##update rate value to table with the latest quantity
			@Order = Order.find_by product_id:params[:productId]
			@Order.update_attributes(ordered_price: productSum, ordered_quantity: params[:productQuantity])

			##calculate cumulative total
			@cumulativeTotal   = Order.where(user_id: session[:user_id], order_status: 0).sum("ordered_price")

			cumulativeText = "Rs.#{@cumulativeTotal}"
			responseCode = 1
		else
			responseCode = 0
		end

		render json: {success: responseCode, html_content: totalValue, cumulativeTotal: cumulativeText}
	end


	def complete_payment
		
	end


	def initiatePayment

		@categories = Category.all

		#require 'paypal-checkout-sdk'
		
		#initiatePayment

		# Creating Access Token for Sandbox
		# client_id 	  = Rails.configuration.application['PAYPAL_CLIENT_ID'] 
		# client_secret = Rails.configuration.application['PAYPAL_CLIENT_SECRET'] 

		# # Creating an environment
		# environment = PayPal::SandboxEnvironment.new(client_id, client_secret)
		# client 		  = PayPal::PayPalHttpClient.new(environment)


		# PAYPAL 6 methods:
		# 1. Set up TRANSACTION
		# 2. Set up Authorization
		# 3. Get TRANSACTION details
		# 4. Capture trranaction
		# 5. Create Authorization
		# 6. Capture an authorization

		require 'paypal-checkout-sdk'

		client_id 	  = Rails.configuration.application['PAYPAL_CLIENT_ID'] 
		client_secret = Rails.configuration.application['PAYPAL_CLIENT_SECRET'] 

		# Creating an environment
		environment = PayPal::SandboxEnvironment.new(client_id, client_secret)
		client 		  = PayPal::PayPalHttpClient.new(environment)

		#### SET UP TRANSACTION - CREATES AN ORDER ID ####

		# request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new

		# request.request_body({
  #     intent: "CAPTURE",
  #     purchase_units: [
  #         {
  #             amount: {
  #                 currency_code: "USD",
  #                 value: "100.00"
  #             }
  #         }
  #     ]
  #   })

		# begin
	 #    # Call API with your client and get a response for your call
	 #    response = client.execute(request)
	 #    #logger.debug "Response: #{response}"
	 #    # If call returns body in response, you can get the deserialized version from the result attribute of the response
	 #    order = response.result
	 #    logger.debug "Create Order response #{order}"
	 #    logger.debug "Create Order Id  #{order.id}"

		# rescue PayPalHttp::HttpError => ioe
	 #    # Something went wrong server-side
	 #    logger.debug "Create Order - Error Status Code: #{ioe.status_code}"
	 #    logger.debug "Create Order - Error header #{ioe.headers['debug_id']}"
		
		# end

		### CAPTURE AN ORDER

		request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest::new('01H58152W0418461V')

		begin
	    # Call API with your client and get a response for your call
	    response = client.execute(request) 
	    
	    # If call returns body in response, you can get the deserialized version from the result attribute of the response
	    order = response.result
	    logger.debug "#Capture response: {order}"
		rescue PayPalHttp::HttpError => ioe
		  # Something went wrong server-side
			logger.debug "Capture Order - Error Status Code: #{ioe.status_code}"
	    logger.debug "Capture Order - Error header #{ioe.headers['debug_id']}"
		end

	end

	private

	def search_params
		params.permit(:search_val)
	end

end