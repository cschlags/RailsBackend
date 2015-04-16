class Batch < ActiveRecord::Base
  serialize :folder, JSON
  Obj = {}
  def access_bucket
    s3 = AWS::S3.new
    bucket = s3.buckets['curateanalytics']
    bucket.objects.each do |obj|
      if obj.key =~ /swipe batches/
        if obj.key =~ /jpg/
          newfolder = sort_objs(obj.key)[0]
          newurl = "https://s3.amazonaws.com/curateanalytics/" + obj.key.gsub('&', '%26').gsub('swipe ', 'swipe+')
          if Obj.key?(newfolder)
            Obj[newfolder] << find_properties(newurl, Obj[newfolder]).first
          else
            Obj.merge!(newfolder => [])
          end    
        end
      end
    end
    return Obj
  end

  def sort_objs(url)
    swipe = url.split("swipe batches/").last.split("/").first
    batch_id = url.split("swipe batches/").last.split("/")[1]
    file = url.split("swipe batches/").last.split("/").last
    return [swipe, batch_id, file]
  end

  def find_properties(url, properties_hash)
    hash = {}
    s = File.join(Rails.root, 'public', 'DatabaseArray.json')
    file = File.read(s)
    data_hash = JSON.parse(file)
    data_hash.each do |main_category|
      main_category.each do |sub_category|
        newurl = url.split("/").last.gsub("%26","&")
        if (newurl == sub_category.split(",").first.split(":").second.split("\"").second)
          sub_category.gsub("\"","")[1..-2].split(",").each do |string|
            properties = string.split(":")
            if (properties.first == "URL") || (properties.first == "File_Name")
              if (properties.first == "URL")
                properties_hash.last.merge!(properties.first.parameterize.underscore.to_sym => url)
                properties_hash.last.merge!(:properties => {})
              else
                properties_hash << hash.merge!(properties.first.parameterize.underscore.to_sym => properties.second)
              end
            else
              if properties_hash.last.key?(:properties)
                if (properties.first == "Properties")
                  properties_hash.last[:properties].merge!(properties.second.gsub!("{","").parameterize.underscore.to_sym => properties.last)
                else
                  properties_hash.last[:properties].merge!(properties.first.parameterize.underscore.to_sym => properties.second)
                end
              end
            end
          end
        end
      end  
    end
  return properties_hash
  end
end