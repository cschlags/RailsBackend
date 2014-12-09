class Wardrobe < ActiveRecord::Base
  belongs_to :user
  serialize :clothes
  after_create :serialize_clothes
  
  def serialize_clothes
     self.clothes = {shirts: nil, pants: nil, shoes: nil, outerwear: nil}
     self.save!
  end
end
