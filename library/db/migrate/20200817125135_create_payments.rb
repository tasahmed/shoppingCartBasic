class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.string :email
      t.string :token
      t.integer :user_id
      t.float :amount
      t.timestamps
    end
  end
end
