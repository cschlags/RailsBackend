class Outfit < ActiveRecord::Base
  belongs_to :user
  serialize :outfits
  after_create :serialize_outfits
  
  def serialize_outfits
     self.outfits = {name: nil, items: {shirts: nil, pants: nil, shoes: nil, outerwear: nil}}
     self.save!
  end
end
