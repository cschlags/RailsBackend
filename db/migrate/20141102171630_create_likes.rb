class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.string :user_uid

      t.timestamps
    end
  end
end
