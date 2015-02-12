class AddLikesToLike < ActiveRecord::Migration
  def change
    add_column :likes, :likes, :text
    add_column :likes, :authentication_token, :string
  end
end
