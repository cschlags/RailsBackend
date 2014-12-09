class AddClothesToWardrobe < ActiveRecord::Migration
  def change
    add_column :wardrobes, :clothes, :text
  end
end
