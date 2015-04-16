class Batch < ActiveRecord::Base
  serialize :batches, JSON
  Obj = {}
  def access_bucket
    s3 = AWS::S3.new
    bucket = s3.buckets['curateanalytics']
    bucket.objects.each do |obj|
      if obj.key =~ /swipe batches/
        if obj.key =~ /jpg/
          newfolder = sort_objs(obj.key)[0]
          newbatch =  sort_objs(obj.key)[1]
          newurl = "https://s3.amazonaws.com/curateanalytics/" + obj.key.gsub('&', '%26').gsub('swipe ', 'swipe+')
          if Obj.key?(newfolder)
            if Obj[newfolder].key?(newbatch)
              Obj[newfolder].merge!(newbatch => [])
              Obj[newfolder][newbatch] << {:filename => newurl, :properties => {}}
              Obj[newfolder][newbatch].last[:properties] = find_properties(newurl, Obj[newfolder][newbatch].last[:properties])
            else
              Obj[newfolder].merge!(newbatch => {})
            end
          else
            Obj.merge!(newfolder=>{})
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

  def find_properties(url, properties_array)
    s = File.join(Rails.root, 'public', 'DatabaseArray.json')
    file = File.read(s)
    data_hash = JSON.parse(file)
    data_hash.each do |main_category|
      main_category.each do |sub_category|
        url = url.split("/").last.gsub("%26","&")
        if (url == sub_category.split(",").first.split(":").second.split("\"").second)
          array = sub_category.split(",")
          array.each do |this|
            name = this.split(":").first.split("\"").second
            if (this.split(":").first.split("\"").second == "URL")
              property = url
            else
              property = this.split(":").second.split("\"").second
            end
            properties_array.merge!(name => property)
          end
        end
      end  
    end
  return properties_array
  end
end