class Batch < ActiveRecord::Base
  serialize :folder, JSON
  
  def access_bucket
    AwsAccess.new('curateanalytics', [], "", {}).sort_through_bucket
  end

  class AwsAccess
    def initialize(bucket_name, array, current, obj)
      @bucket_name = bucket_name
      @array = array
      @current = current
      @obj = obj
      @newfolder
      @newbatch
      @newurl
    end

    def access_bucket
      return AWS::S3.new.buckets[@bucket_name]
    end

    def sort_through_bucket
      access_bucket.objects.each do |obj|
        if obj_is_swipe_batch?(obj)
          create_new_instances(obj)
          if !obj_contains_key?
            add_newfolder_key
          end
          if !current_equals_batch?
            @current = @newbatch
            if array_not_array?
              @obj[@newfolder] << @array
            end
          end
          @array << Properties.new(@newurl).find_properties
        end
      end
      return @obj
    end

    def obj_is_swipe_batch?(obj)
      return ((obj.key =~ /swipe batches/) && (obj.key =~ /jpg/))
    end

    def create_new_instances(obj)
      @newfolder = obj.key.split("/")[1]
      @newbatch = obj.key.split("/")[obj.key.split("/").length-2]
      @newurl = "https://s3.amazonaws.com/curateanalytics/" + obj.key.gsub('&', '%26').gsub('swipe ', 'swipe+')
    end

    def obj_contains_key?
      @obj.key?(@newfolder)
    end

    def add_newfolder_key
      @obj.merge!(@newfolder => [])
    end

    def current_equals_batch?
      @current == @newbatch
    end

    def array_not_array?
      @array != []
    end
  end

  class Properties
    def initialize(bucket_url)
      @bucket_url = bucket_url
      @hash = {}
    end

    def find_properties
      read_json
      parse_json
      parse_main
      parse_sub
      return @hash
    end

    def read_json
      @json = JSON.parse(File.read(File.join(Rails.root, 'public', 'DatabaseArray.json')))
    end

    def parse_json
      @json.each do |main|
        @main = main
      end
    end

    def parse_main
      @main.each do |sub|
        @sub = sub
      end
    end

    def parse_sub
      @sub.gsub("\"","")[1..-2].split(",").each do |properties|
        @property = properties.split(":")
        if is_URL?
          @hash.merge!(@property.first.parameterize.underscore.to_sym => @bucket_url)
          @hash.merge!(:properties => {})
        elsif is_File_Name?
          @hash.merge!(@property.first.parameterize.underscore.to_sym => @property.second)
        elsif is_Main?
          @hash[:properties].merge!(@property.second.gsub!("{","").parameterize.underscore.to_sym => @property.last)
        else
          @hash.merge!(@property.first.parameterize.underscore.to_sym => @property.second)
        end
      end
    end

    def is_URL?
      @property.first == "URL"
    end

    def is_File_Name?
      @property.first == "File_Name"
    end

    def is_Main?
      @property.second == "{Main_Category"
    end
  end
end