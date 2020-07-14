class CreateCategories < ActiveRecord::Migration[6.0]

    def self.up
      	create_table :categories do |t|
            t.column :name, :string, :limit=>100, :null => false
            t.column :description, :string, :limit=>300, :null => false
            t.column :created_time, :timestamp, :default => Time.now
        end
    end

    def self.down
        drop_table:categories
    end
end
