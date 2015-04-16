class Wardrobe < ActiveRecord::Base
  require 'rubygems'
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
    s = File.join(Rails.root, 'public', 'DatabaseArray.json')
    file = File.read(s)
    data_hash = JSON.parse(file)
    data_hash.each do |main_category|
      main_category.each do |sub_category|
        self.wardrobe.keys.each do |key|
          self.wardrobe[key].each do |files|
            @wardrobe_file_name = files[:filename].split("/").last.gsub("%26","&")
            if (@wardrobe_file_name == sub_category.split(",").first.split(":").second.split("\"").second)
              array = sub_category.split(",")
              array.each do |this|
                name = this.split(":").first.split("\"").second
                if (this.split(":").first.split("\"").second == "URL")
                  property = files[:filename]
                else
                  property = this.split(":").second.split("\"").second
                end
                files[:properties].merge!(name => property)
              end
            end
          end
        end
      end  
    end
  end
end