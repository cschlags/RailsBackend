class AddClothesToWardrobe < ActiveRecord::Migration
  def change
    add_column :wardrobes, :wardrobe, :text
    add_column :wardrobes, :authentication_token, :string
  end
end
