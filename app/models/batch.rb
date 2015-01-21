class Batch < ActiveRecord::Base
  before_create :access_bucket
  Obj = {:folder => [], :batch_number => [], :url => []}
  def access_bucket
    s3 = AWS::S3.new
    bucket = s3.buckets['curateanalytics']
    bucket.objects.each do |obj|
      if obj.key =~ /swipe batches/
        if obj.key =~ /jpg/
          Obj[:folder] << sort_objs(obj.key)[0]
          Obj[:batch_number] << sort_objs(obj.key)[1]
          Obj[:url] << sort_objs(obj.key)[2]
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