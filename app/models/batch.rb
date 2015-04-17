class Batch < ActiveRecord::Base
  serialize :folder, JSON
  Obj = {}
  def access_bucket
    array = []
    current = ""
    s3 = AWS::S3.new
    bucket = s3.buckets['curateanalytics']
    bucket.objects.each do |obj|
      if obj.key =~ /swipe batches/
        if obj.key =~ /jpg/
          newfolder = sort_objs(obj.key)[0]
          newbatch = sort_objs(obj.key)[1]
          newurl = "https://s3.amazonaws.com/curateanalytics/" + obj.key.gsub('&', '%26').gsub('swipe ', 'swipe+')
          if Obj.key?(newfolder)
            if current == newbatch
              array << find_properties(newurl)
            else
              current = newbatch
              if array != []
                Obj[newfolder] << array
              end
            end
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

  def find_properties(url)
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
                hash.merge!(properties.first.parameterize.underscore.to_sym => url)
                hash.merge!(:properties => {})
              else
                hash.merge!(properties.first.parameterize.underscore.to_sym => properties.second)
              end
            else
              if hash.key?(:properties)
                if (properties.first == "Properties")
                  hash[:properties].merge!(properties.second.gsub!("{","").parameterize.underscore.to_sym => properties.last)
                else
                  hash[:properties].merge!(properties.first.parameterize.underscore.to_sym => properties.second)
                end
              end
            end
          end
        end
      end  
    end
  return hash
  end
end