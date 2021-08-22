class Admin::ProductController < ApplicationController

	layout "admin"

	before_action :restrict_user_by_role 
	before_action :set_product, only: [:update, :edit, :destroy] 

	def list
		# TO DO ORDER recordset colummns as per requirement
		#pass this value to get the table header
		#@columns = Product.joins(:category).select("products.name as Product, categories.name as Category, products.description, products.image_url, products.price, products.quantity, products.created_date").first
		@columns = Array['product', 'category', 'description', 'image_url', 'price', 'quantity', 'created_date']
		
		#logger.debug "Product columns #{@columns.to_yaml}"
		#pass this value to get the table rows
		@rows    = Product.joins(:category).select("products.name as product, categories.name as category, products.description as description, products.image_url, products.price, products.quantity, products.created_date, products.id").order("created_date ASC").paginate(page: params[:page], per_page: 10)
	  
		#pass edit and delete routes to view to display in @curd variable
		@curd    = Array('Edit' => '/admin/product/edit', 'Delete' => '/admin/product/delete')
	end

	def new
		@product = Product.new
		@category = Category.all
	end

	def create

		if (!params[:product][:image_url].nil?)
			new_filename = upload_image(params[:product][:image_url])
	  	params[:product][:image_url] = "/uploads/#{new_filename}"
	  end

	  params[:product][:created_date] = DateTime.now

		@product = Product.new(set_params)
		
		if @product.save
			redirect_to "/admin/product/list", flash: {'success' => 'Product was successfully added'}
		else
			redirect_to "/admin/product/new", flash: {'danger' => @product.errors.full_messages}
		end
	end

	def edit
		@category = Category.all
	end

	def update
		#chekc if image is uploaded
		if (params[:product][:image_url])
			image_url 	 = params[:product][:image_url]
			new_filename = upload_image(image_url)
	  	params[:product][:image_url] = "/uploads/#{new_filename}"
	  else
	  	params[:product][:image_url] = @product.image_url
	  end

		if @product.update(set_params)
			redirect_to "/admin/product/list", flash: {'success' => 'Product was successfully edited'}
		else
			redirect_to "/admin/product/edit/#{params[:id]}", flash: {'danger' => @product.errors.full_messages}
		end
		#redirect_to '/admin/product/list'
	end

	def destroy
		@product.destroy
		redirect_to '/admin/product/list'
	end

	def checkout
		
	end

	private

	def upload_image(param_image)

		random_text   = generate_activation_code(6)

		uploaded_file = param_image

		#add timestamp to filename mark unique filename
  	file_name 	 = uploaded_file.original_filename.rpartition(".").first
  	file_ext  	 = uploaded_file.original_filename.rpartition(".").last
		new_filename = file_name+'_'+random_text+'.'+file_ext
		#file upload functionality
  	File.open(Rails.root.join('public', 'uploads', new_filename), 'wb') do |file|
    	file.write(uploaded_file.read)
  	end

  	#logger.debug "File Params #{uploaded_file.to_yaml}"
  	return new_filename

	end

	def set_product
  	@product  = Product.find(params[:id])
  end

  def set_params
  	params.require(:product).permit(:name, :category_id, :description, :image_url, :price, :quantity, :created_date)
  end

end