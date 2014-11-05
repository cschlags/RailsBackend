class CreateWardrobes < ActiveRecord::Migration
  def change
    create_table :wardrobes do |t|
      t.string :user_uid

      t.timestamps
    end
  end
end
