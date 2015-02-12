class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.string :user_id
      t.string :authentication_token

      t.timestamps
    end
  end
end
