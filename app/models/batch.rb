class Batch < ActiveRecord::Base
  before_create :access_bucket

  def access_bucket
    s3 = AWS::S3.new
    bucket = s3.buckets['curateanalytics']
    bucket.objects.each do |obj|
      if obj =~ /swipe batches/i && obj =~ /jpg/i
        self.sort_objs(obj.key)
      end
    end
  end

  def sort_objs(url)
    swipe = url.split("swipe batches/").last
    batch_id = url.split("swipe batches/")[1]
    folder = swipe.split("/")[0] 
    self.initialize(batch_id, folder, url)
  end

  def initialize(batch_id, folder, url)
    batch = Batch.new
    batch.batch_id = batch_id
    batch.folder = folder
    batch.url = url
    batch.save!
  end
end