# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sam = User.create([{id: '3',name: 'Samuel Dean', email: 'samdean@gmail.com', image: 'profile.jpg', preferences: {height: '172', weight: '175', age: '32', waist_size: '36', inseam: '30', preferred_pants_fit: 'm', shirt_size: 'm', preffered_shirt_fit: 'regular', shoe_size: '10'}}])
sam_wardrobe = Wardrobe.create([{id: '3', user_id: '3', wardrobe: {shirts: [], pants: [], shoes: [], outerwear: []}}])