class CreateOrders < ActiveRecord::Migration[6.0]
  
  def self.up
    create_table :orders do |t|
      t.column :product_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
      t.column :ordered_price, :float, :null => false
      t.column :ordered_quantity, :integer, :null => false
      t.column :orderd_date, :timestamp, :null => false
      t.column :order_status, :integer, :default => 0
      t.column :payment_id, :integer, :default => 0
      t.timestamps
    end
  end

  def self.down
  	drop_table :orders
  end

end
