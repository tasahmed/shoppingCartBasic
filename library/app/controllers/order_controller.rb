class OrderController < ApplicationController

	layout 'standards'

	def confirm
		#logger.debug 'inside confirm function'
		#logger.debug "Printing config variable: #{@payPalClientId}" 

		@categories = Category.all

		if params[:product_id]

			product_id = params[:product_id]
			#@product   = Product.find(product_id)
			@product   = Product.find(product_id)

			## call save method to save the new row value
			if !Order.where(:product_id => params[:product_id], :order_status => 0).exists?
				@orderId = self.save
				
				@quantity = 1
				#flash[:notice] = '<div class="alert alert-success" role="alert">Product saved to your order list</div>'.html_safe
			else
				#flash[:notice] = '<div class="alert alert-info" role="alert">Product already available in your Order list, increase the quantity if you need !</div>'.html_safe
				
				##update the product price and quantity as per the latest update by customer

				@order   = Order.find_by product_id: product_id
				@orderId = @order.id

				logger.debug "Quantity: #{@order.ordered_quantity}"

				#@product.price  = @order.ordered_price
				@quantity 		= @order.ordered_quantity
			end	
			
			##get list of items already order to display in list
			##get current user id
			@user_id = session[:user_id]

			@products = Product.joins(:orders).where(orders: {user_id: @user_id, order_status: 0}).where.not(id: product_id).select("products.id as product_id, products.name, products.description, products.image_url, products.price as product_price, products.quantity as product_quantity, products.created_date, orders.id as order_id, orders.ordered_price, orders.ordered_quantity, orders.order_status")

			#@products = Product.joins(:orders).where(orders: {user_id: @user_id, order_status: 0}).select("products.id as product_id, products.name, products.description, products.image_url, products.price as product_price, products.quantity as product_quantity, products.created_date, orders.id as order_id, orders.ordered_price, orders.ordered_quantity, orders.order_status")

			logger.debug "All Products: #{@products.to_yaml}"

			#get total number of products in order list count
			@order_count = Order.where(user_id: @user_id, order_status: 0).count
			@order_sum   = Order.where(user_id: @user_id, order_status: 0).sum("ordered_price")

			session[:order_sum] = @order_sum 

		else
			flash[:notice] ='ERROR: Not able to add to order'
  		render :new
		end
	end

	def save
		if @product.id
			#create new value
			@order = Order.create(product_id: @product.id, 
														 user_id: session[:user_id], 
														 ordered_price: @product.price,
														 ordered_quantity: 1,
														 orderd_date: DateTime.now, 
														 created_at: DateTime.now)

			logger.debug "last save order id #{@order.id}"
			orderId = @order.id
		else
			flash[:notice] ='ERROR: Not able to add Order'
  		render :new
  		orderId = 0
		end	

		return orderId
	end

	def process_payment

		logger.debug "Email: #{session[:email]}"
		logger.debug "Token: #{params[:payment]["token"]}"
		logger.debug "User Id: #{session[:user_id]}"
		logger.debug "params: #{params.to_json}"

		@payment = Payment.new({ email: session[:email], token: params[:payment]["token"], user_id: session[:user_id], amount: session[:order_sum], created_at: Date.today, updated_at: Date.today })
		flash[:error] = "Please check errors #{@payment.errors}" unless @payment.valid?

		begin

			@payment.process_payment(session[:order_sum], 'test')

			if @payment.save
				#update payment id to respective orders and set the order_status to paid
				@order = Order.where(user_id: session[:user_id], order_status: 0)
				@order.update({order_status: 1, payment_id: @payment.id})

				redirect_to "/product/list", flash: {'success' => 'Payment was successfully done, the item will be delieverd to your address'}
			else
				logger.debug "Payment.save not happening #{@payment.errors.full_messages}"
			end	

			session[:order_sum] = nil

			rescue Exception => e

				flash[:error] = e.message
				logger.debug "Exception occured #{e.message}"
				#resource.destroy

				puts 'Payment failed'

				redirect_to '/product/list'

		end
	end
end