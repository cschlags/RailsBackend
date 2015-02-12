class Like < ActiveRecord::Base
  belongs_to :user
  serialize :likes
  before_create :add_authentication_token
  after_create :serialize_likes
  
  def serialize_likes
     self.likes = {type: nil, image: nil}
     self.save!
  end

  def add_authentication_token
    self.authentication_token = user.authentication_token
    self.save!
  end
end
