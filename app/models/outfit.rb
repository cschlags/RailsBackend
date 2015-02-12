class Outfit < ActiveRecord::Base
  belongs_to :user
  serialize :outfits
  before_create :add_authentication_token
  after_create :serialize_outfits
  
  def serialize_outfits
     self.outfits = {name: nil, items: {shirts: nil, pants: nil, shoes: nil, outerwear: nil}}
     self.save!
  end

  def add_authentication_token
    self.authentication_token = user.authentication_token
    self.save!
  end
end
