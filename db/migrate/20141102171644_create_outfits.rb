class CreateOutfits < ActiveRecord::Migration
  def change
    create_table :outfits do |t|
      t.string :user_uid

      t.timestamps
    end
  end
end
