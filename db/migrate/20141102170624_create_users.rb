class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email
      t.string :image
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.string :height
      t.integer :weight
      t.integer :age
      t.integer :waist_size
      t.integer :inseam
      t.string :preferred_pants_fit
      t.string :shirt_size
      t.string :preferred_shirt_fit
      t.string :shoe_size

      t.timestamps
    end
  end
end
