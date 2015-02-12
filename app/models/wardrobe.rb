class Wardrobe < ActiveRecord::Base
  belongs_to :user
  serialize :wardrobe
  after_create :serialize_wardrobe

  def serialize_wardrobe
    self.authentication_token = user.authentication_token
    self.wardrobe = {:tops => ["https://s3.amazonaws.com/curateanalytics/tops/hoodie/H%26M.Hoodie.Burgundy.jpg","https://s3.amazonaws.com/curateanalytics/tops/hoodie/H%26M.Hoodie.Charcoal.jpg","https://s3.amazonaws.com/curateanalytics/tops/hoodie/H%26M.Hoodie.DarkGreen.jpg","https://s3.amazonaws.com/curateanalytics/tops/hoodie/H%26M.Hoodie.Gray.jpg","https://s3.amazonaws.com/curateanalytics/tops/hoodie/H%26M.Hoodie.Green.jpg"], :bottoms => ["http://s3.amazonaws.com/curateanalytics/bottoms/pants/5pocket%20pants/regular/H&M_5-Pocket_Regular_Black.jpg","http://s3.amazonaws.com/curateanalytics/bottoms/pants/5pocket%20pants/regular/H&M_5-Pocket_Regular_Blue.jpg","https://s3.amazonaws.com/curateanalytics/bottoms/shorts/twill/Uniqlo_Shorts_Stretch_Twill_Blue.jpg","https://s3.amazonaws.com/curateanalytics/bottoms/shorts/twill/Uniqlo_Shorts_Stretch_Twill_Brown.jpg","https://s3.amazonaws.com/curateanalytics/bottoms/shorts/twill/Uniqlo_Shorts_Stretch_Twill_Charcoal.jpg"]}
    self.save!
  end
end