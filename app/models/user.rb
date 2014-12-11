class User < ActiveRecord::Base
  has_one :like
  has_one :outfit
  has_one :wardrobe
  before_save :change_curate_user_id
  after_create :create_wardrobe, :create_outfit, :create_like
  serialize :preferences
  
  def self.from_omniauth(auth_hash)
    where(auth_hash.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth_hash.provider
      user.uid = auth_hash.uid
      user.name = auth_hash.info.name
      user.email = auth_hash.info.email
      user.image = auth_hash.info.image
      user.oauth_token = auth_hash.credentials.token
      user.oauth_expires_at = Time.at(auth_hash.credentials.expires_at)
      user.preferences = { height: nil, weight: nil, age: nil, waist_size: nil, inseam: nil, preferred_pants_fit: nil, shirt_size: nil, preferred_shirt_fit: nil, shoe_size: nil}
      user.save!
    end
  end

  def change_curate_user_id
    self.curate_user_id = "curate"+rand(9).to_s+rand(9).to_s+rand(9).to_s+
    rand(9).to_s+rand(9).to_s
  end
end