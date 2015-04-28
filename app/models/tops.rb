class Tops < ActiveRecord::Base
  serialize :properties
  serialize :batch_information
  belongs_to :batch
  attr_accessible :batch_information, :file_name, :url, :properties
end