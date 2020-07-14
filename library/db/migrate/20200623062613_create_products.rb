class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.column :name, :string, :limit =>150, :null => false
      t.column :variant_id, :integer
      t.column :category_id, :integer
      t.column :description, :string, :limit=>300
      t.column :image_url, :string
      t.column :price, :float
      t.column :quantity, :integer
      t.column :seller_id, :integer
      t.column :created_date,  :timestamp, :null => false
    end
  end
end
