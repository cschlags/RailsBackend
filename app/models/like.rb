class Like < ActiveRecord::Base
  belongs_to :user
  serialize :likes
  after_create :serialize_likes
  
  def serialize_likes
     self.likes = {type: nil, image: nil}
     self.save!
  end
end
