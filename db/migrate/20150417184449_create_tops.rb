class CreateTops < ActiveRecord::Migration
  def change
    create_table :tops do |t|
      t.string :batch_folder
      t.string :batch_number
      t.string :file_name
      t.string :url
      t.text :properties
    end
  end
end
