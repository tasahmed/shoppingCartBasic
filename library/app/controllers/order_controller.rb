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
			if !Order.where(:product_id => params[:product_id]).exists?
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

			@products = Product.joins(:orders).where(orders: {user_id: @user_id}).where.not(id: product_id).select("products.id as product_id, products.name, products.description, products.image_url, products.price as product_price, products.quantity as product_quantity, products.created_date, orders.id as order_id, orders.ordered_price, orders.ordered_quantity, orders.order_status")

			logger.debug "All Products: #{@products.to_yaml}"

			#get total number of products in order list count
			@order_count = Order.where(user_id: @user_id, order_status: 0).count
			@order_sum   = Order.where(user_id: @user_id, order_status: 0).sum("ordered_price")

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

end