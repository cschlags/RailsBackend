class AddOutfitsToOutfit < ActiveRecord::Migration
  def change
    add_column :outfits, :outfits, :text
    add_column :outfits, :authentication_token, :string
  end
end
