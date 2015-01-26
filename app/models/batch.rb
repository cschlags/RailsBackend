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
          newbatch =  sort_objs(obj.key)[1]
          newurl = obj.key

          if Obj.key?(newfolder)
            if Obj[newfolder].key?(newbatch)
              if Obj[newfolder][newbatch].key?(:filenames)
                Obj[newfolder][newbatch][:filenames] << newurl
              else
                Obj[newfolder][newbatch].merge!(filenames:[])
              end
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
end