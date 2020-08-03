class ProductController < ApplicationController
	
	layout 'standards'

	### function to list all products in list page based on added date
	def list
		@categories = Category.all
		@products   = Product.order("created_date DESC")
	end

	def show
		@product = Product.find(params[:id])
		@categories   = Category.all
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

	private

	def search_params
		params.permit(:search_val)
	end
	
end