# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Category.delete_all

#Category.create!([{:name =>"Home Appliances", :description =>"Hourse hold appliances"}, 
#				   {:name =>"Mobile Phones", :description =>"Mobile phone and accessories"},
#				   {:name =>"Furniture", :description =>"Home furniture like tables, chairs etc."},
#				   {:name =>"Apparales", :description =>"Men and women fashion wear."},
#				   {:name =>"Sports", :description =>"Sports and other accessories."}]) 

#p "Created #{Category.count} categories"


#p "Created #{Product.count} products"

Product.__elasticsearch__.create_index!(force: true)

#Category.delete_all

#Category.create!([{:name =>"Home Appliances", :description =>"Hourse hold appliances"}, 
#				   {:name =>"Mobile Phones", :description =>"Mobile phone and accessories"},
#				   {:name =>"Furniture", :description =>"Home furniture like tables, chairs etc."},
#				   {:name =>"Apparales", :description =>"Men and women fashion wear."},
#				   {:name =>"Sports", :description =>"Sports and other accessories."}]) 

#p "Created #{Category.count} categories"

Product.delete_all

Product.create!(name: 'Redmi note 5 Pro', 
				variant_id: 0, 
				category_id: 37, 
				description: 'Redmi Note 5 Pro mobile phone', 
				image_url: 'redmi6.jpg',
				price: 12000,
				quantity: 50,
				seller_id: 0,
				created_date: Date.today)

Product.create!(name: 'Redmi note 6 Pro', 
				variant_id: 0, 
				category_id: 37, 
				description: 'Redmi Note 6 Pro mobile phone', 
				image_url: 'redmi6.jpg',
				price: 14000,
				quantity: 150,
				seller_id: 0,
				created_date: Date.today)

Product.create!(name: 'Redmi note 7 Pro', 
				variant_id: 0, 
				category_id: 37, 
				description: 'Redmi Note7 Pro mobile phone', 
				image_url: 'redmi7.jpg',
				price: 16000,
				quantity: 150,
				seller_id: 0,
				created_date: Date.today)

Product.create!(name: 'Redmi note 8 Pro', 
				variant_id: 0, 
				category_id: 37, 
				description: 'Redmi Note8 Pro mobile phone', 
				image_url: 'redmi8.jpg',
				price: 18000,
				quantity: 150,
				seller_id: 0,
				created_date: Date.today)

Product.create!(name: 'Redmi note 9 Pro', 
				variant_id: 0, 
				category_id: 37, 
				description: 'Redmi Note 9 Pro mobile phone', 
				image_url: 'redmi9.jpg',
				price: 21000,
				quantity: 120,
				seller_id: 0,
				created_date: Date.today)

Product.create!(name: 'Samsung Galaxy Pro', 
				variant_id: 0, 
				category_id: 37, 
				description: 'Samsung Galaxy Pro', 
				image_url: 'redmi6.jpg',
				price: 21000,
				quantity: 120,
				seller_id: 0,
				created_date: Date.today)

Product.create!(name: 'Reading Table', 
				variant_id: 0, 
				category_id: 38, 
				description: 'Large reading table', 
				image_url: 'table.png',
				price: 21000,
				quantity: 120,
				seller_id: 0,
				created_date: Date.today)