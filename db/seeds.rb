# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# Examples:
# #
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts "destroy database.."
sleep(1)
Gossip.destroy_all
PrivateMessage.destroy_all
City.destroy_all
Tag.destroy_all
User.destroy_all

puts "ok"
puts "delete from sqlite_sequence..."
sleep(1)
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'gossips'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'private_messages'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'cities'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'tags'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'users'")
puts "Sucess, old DB deleted"
puts ""

sleep(1)

puts "generate new DB..."

puts ""
puts "_______________________________"
puts ""

sleep(1)

10.times do
	city = City.create!(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
  puts "#{city.name} is a little Gossip World"
end
sleep(1)

puts "_______________________________"
puts ""

15.times do 
  user = User.create!(city_id: City.all.sample.id, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::SiliconValley.quote, email: Faker::Internet.email, age: Faker::Number.between(1, 100))
  puts ""
  puts "user #{user.first_name} #{user.last_name} is #{user.age} yo"
  sleep(0.05)
  puts "#{user.first_name}'s description :"
  puts "#{user.description}"
  puts ""
  puts "~~~~~~~~~~~~~~~~~~~next~~~~~~~~~~~~~~~~>"
end
sleep(1)

puts "_______________________________"
puts ""

20.times do 
  gossip = Gossip.create!(user_id: User.all.sample.id, title: Faker::TvShows::SiliconValley.invention, content: Faker::TvShows::Community.quotes)
  puts "User #{gossip.user_id} post :"
  puts "title : #{gossip.title}"
  puts "~~~~~~~~~~~~~"
  sleep(0.05)
  puts "User #{gossip.user_id} said:"
  puts "#{gossip.content}"
end

sleep(1)

puts "_______________________________"
puts ""

10.times do 
  tag = Tag.create!(title: Faker::Hipster.word)
  puts "hashtag ##{tag.title}"
  puts ""
end

sleep(1)

puts "_______________________________"
puts ""

15.times do 
  private_message = PrivateMessage.create!(sender_id: User.all.sample.id, recipient_id: User.all.sample.id, content: Faker::Hipster.paragraph)
  puts "_______________"
  puts ""
  puts "From : User #{private_message.sender_id}"
  puts "To : User #{private_message.recipient_id}"
  puts ""
  sleep(0.05)
  puts "body :"
  puts "#{private_message.content}"
  puts ""
end

puts "_______________________________"
puts ""
sleep(2)
puts "ALL GOOD, DB fresh and ready to be explored like as life"