class CreateWardrobes < ActiveRecord::Migration
  def change
    create_table :wardrobes do |t|
      t.string :user_id

      t.timestamps
    end
  end
end
