class Like < ActiveRecord::Base
  belongs_to :user
  serialize :likes
  after_create :serialize_likes
  
  def serialize_likes
    self.user_id = user.id
    self.authentication_token = user.authentication_token
    self.likes = {type: nil, image: nil}
    self.save!
  end
end
