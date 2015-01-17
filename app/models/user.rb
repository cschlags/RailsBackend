class User < ActiveRecord::Base
  before_create do |doc|
    doc.api_key = doc.generate_api_key
  end
  has_one :like
  has_one :outfit
  has_one :wardrobe
  # before_create :generate_api_key
  after_create :create_wardrobe, :create_outfit, :create_like
  serialize :preferences
  
  def self.from_omniauth(auth_hash)
    where(auth_hash.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.curate_user_id = "curate"+rand(9).to_s+rand(9).to_s+rand(9).to_s+
        rand(9).to_s+rand(9).to_s
      user.provider = auth_hash.provider
      user.uid = auth_hash.uid
      user.name = auth_hash.info.name
      user.email = auth_hash.info.email
      user.image = auth_hash.info.image
      user.oauth_token = auth_hash.credentials.token
      user.oauth_expires_at = Time.at(auth_hash.credentials.expires_at)
      user.preferences = { height: nil, weight: nil, age: nil, waist_size: nil, inseam: nil, preferred_pants_fit: nil, shirt_size: nil, preferred_shirt_fit: nil, shoe_size: nil}
      user.api_key = SecureRandom.base64.tr('+/=', 'Qrt')
      user.save!
    end
  end

  def generate_api_key
  loop do
    token = SecureRandom.base64.tr('+/=', 'Qrt')
    break token unless User.exists?(api_key: token)
  end
end
end