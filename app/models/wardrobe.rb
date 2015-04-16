class Wardrobe < ActiveRecord::Base
  require 'rubygems'
  require 'json'

  belongs_to :user
  serialize :wardrobe
  after_create :serialize_wardrobe

  def serialize_wardrobe
    self.user_id = user.id
    self.authentication_token = user.authentication_token
    self.wardrobe = {:tops => [{:file_name => "",
      :url => "https://s3.amazonaws.com/curateanalytics/tops/hoodie/H%26M.Hoodie.Burgundy.jpg",
      :properties => {}
     },{:file_name => "",
      :url => "https://s3.amazonaws.com/curateanalytics/tops/hoodie/H%26M.Hoodie.Charcoal.jpg",
      :properties => {}
     },{:file_name => "",
      :url => "https://s3.amazonaws.com/curateanalytics/tops/hoodie/H%26M.Hoodie.DarkGreen.jpg",
      :properties => {}
     },{:file_name => "",
      :url => "https://s3.amazonaws.com/curateanalytics/tops/hoodie/H%26M.Hoodie.Gray.jpg",
      :properties => {}
     },{:file_name => "",
      :url => "https://s3.amazonaws.com/curateanalytics/tops/hoodie/H%26M.Hoodie.Green.jpg",
      :properties => {}
     }],
     :bottoms => [{:file_name => "",
      :url => "http://s3.amazonaws.com/curateanalytics/bottoms/pants/5pocket%20pants/regular/H&M_5-Pocket_Regular_Black.jpg",
      :properties => {}
     },{:file_name => "",
      :url => "http://s3.amazonaws.com/curateanalytics/bottoms/pants/5pocket%20pants/regular/H&M_5-Pocket_Regular_Blue.jpg",
      :properties => {}
     },{:file_name => "",
      :url => "https://s3.amazonaws.com/curateanalytics/bottoms/shorts/twill/Uniqlo_Shorts_Stretch_Twill_Blue.jpg",
      :properties => {}
     },{:file_name => "",
      :url => "https://s3.amazonaws.com/curateanalytics/bottoms/shorts/twill/Uniqlo_Shorts_Stretch_Twill_Brown.jpg",
      :properties => {}
     },{:file_name => "",
      :url => "https://s3.amazonaws.com/curateanalytics/bottoms/shorts/twill/Uniqlo_Shorts_Stretch_Twill_Charcoal.jpg",
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
            @wardrobe_url = files[:url].split("/").last.gsub("%26","&")
            if (@wardrobe_url == sub_category.split(",").first.split(":").second.split("\"").second)
              sub_category.gsub("\"","")[1..-2].split(",").each do |string|
                properties = string.split(":")
                if (properties.first == "Properties")
                  files[:properties].merge!(properties.second.gsub!("{","").parameterize.underscore.to_sym => properties.last)
                elsif (properties.first == "File_Name")
                  files[:file_name] = properties.second
                elsif (properties.first != "URL")
                  files[:properties].merge!(properties.first.parameterize.underscore.to_sym => properties.second)
                end
              end
            end
          end
        end
      end  
    end
  end
end