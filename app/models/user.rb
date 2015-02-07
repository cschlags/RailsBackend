class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :omniauth_providers => [:facebook]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :remember_me, :encrypted_password
  has_one :like
  has_one :outfit
  has_one :wardrobe
  before_create :create_batch
  after_create :create_wardrobe, :create_outfit, :create_like
  serialize :preferences
  before_save :ensure_authentication_token
 
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.preferences = { height: nil, weight: nil, age: nil, waist_size: nil, inseam: nil, preferred_pants_fit: nil, shirt_size: nil, preferred_shirt_fit: nil, shoe_size: nil}
      user.save!
    end
  end


  def create_batch
    batch = Batch.new
    obj = batch.access_bucket
    i = 0
    while i < obj.length do
      @batch = Batch.new
      @batch.folder = {}
      @batch.folder[obj.first.first] = obj.first.second
      obj.shift.first
      @batch.save!
      i = i+1
    end
  end
   
  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end