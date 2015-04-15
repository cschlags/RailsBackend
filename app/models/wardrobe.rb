class Wardrobe < ActiveRecord::Base
  require 'rubygems'
  require 'roo'
  require 'json'

  belongs_to :user
  serialize :wardrobe
  after_create :serialize_wardrobe

  def serialize_wardrobe
    self.user_id = user.id
    self.authentication_token = user.authentication_token
    self.wardrobe = {:tops => [{:filename => "https://s3.amazonaws.com/curateanalytics/tops/hoodie/H%26M.Hoodie.Burgundy.jpg",
      :properties => {}
     },{:filename => "https://s3.amazonaws.com/curateanalytics/tops/hoodie/H%26M.Hoodie.Charcoal.jpg",
      :properties => {}
     },{:filename => "https://s3.amazonaws.com/curateanalytics/tops/hoodie/H%26M.Hoodie.DarkGreen.jpg",
      :properties => {}
     },{:filename => "https://s3.amazonaws.com/curateanalytics/tops/hoodie/H%26M.Hoodie.Gray.jpg",
      :properties => {}
     },{:filename => "https://s3.amazonaws.com/curateanalytics/tops/hoodie/H%26M.Hoodie.Green.jpg",
      :properties => {}
     }],
     :bottoms => [{:filename => "http://s3.amazonaws.com/curateanalytics/bottoms/pants/5pocket%20pants/regular/H&M_5-Pocket_Regular_Black.jpg",
      :properties => {}
     },{:filename => "http://s3.amazonaws.com/curateanalytics/bottoms/pants/5pocket%20pants/regular/H&M_5-Pocket_Regular_Blue.jpg",
      :properties => {}
     },{:filename => "https://s3.amazonaws.com/curateanalytics/bottoms/shorts/twill/Uniqlo_Shorts_Stretch_Twill_Blue.jpg",
      :properties => {}
     },{:filename => "https://s3.amazonaws.com/curateanalytics/bottoms/shorts/twill/Uniqlo_Shorts_Stretch_Twill_Brown.jpg",
      :properties => {}
     },{:filename => "https://s3.amazonaws.com/curateanalytics/bottoms/shorts/twill/Uniqlo_Shorts_Stretch_Twill_Charcoal.jpg",
      :properties => {}
     }]}
     find_properties
    self.save!
  end

  def find_properties
    binding.pry
    book = Roo::Excelx.new("DatabaseTest.xlsx")
    sheets = book.sheets
    clothes = Array.new(sheets.count)
    counter = 0
  end
end