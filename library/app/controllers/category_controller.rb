class CategoryController < ApplicationController

	layout 'standards'

	def list

		@categories = Category.all

		if params[:categoryId]
			@products   = Product.where(category_id: params[:categoryId])
		else
			@products   = Product.all
		end	
	end

end