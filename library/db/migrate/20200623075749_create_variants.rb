class CreateVariants < ActiveRecord::Migration[6.0]
  
  def self.up
    create_table :variants do |t|
      t.column :name, :string, :limit=>100 , :null => false
      t.column :description, :string, :limit=>300 , :null => false
      t.column :comment, :string, :limit=>500
      t.column :created_time, :timestamp, :null =>false
      t.timestamps
    end
  end

  def self.down
  	drop_table :variants
  end
end
