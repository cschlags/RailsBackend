class CreateOutfits < ActiveRecord::Migration
  def change
    create_table :outfits do |t|
      t.string :user_id

      t.timestamps
    end
  end
end
