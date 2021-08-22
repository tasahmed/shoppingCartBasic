class CreateUsers < ActiveRecord::Migration[6.0]
  
  def self.up
    create_table :users do |t|
      t.column :name, :string, :limit => 100, :null => false
      t.column :password_digest, :string
      t.column :email, :string, default: "", null: false
      t.column :address_payment, :string, :limit =>500
      t.column :address_shipping, :string, :limit =>500
      t.column :user_status, :integer, default: 1
      t.column :user_type, :integer, default: 0
      t.column :created_at, :timestamp, :null =>false
      t.column :updated_at, :datetime, :null =>false
    end
  end

  def self.down
  	drop_table :users
  end

end
