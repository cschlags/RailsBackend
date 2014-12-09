class Wardrobe < ActiveRecord::Base
  belongs_to :user
  serialize :wardrobe
  after_create :serialize_wardrobe
  
  def serialize_wardrobe
     self.wardrobe = {shirts: nil, pants: nil, shoes: nil, outerwear: nil}
     self.save!
  end
end
