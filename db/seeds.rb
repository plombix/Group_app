# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Learner.delete_all
Group.delete_all
User.create!(id: 1, email: 'plombix@gmail.com', password:"alcatraz", password_confirmation:"alcatraz")
10.times do |i|
	Learner.create!(name: "test_#{i}",notes: "random_stuffs")
	i+=1
end
Group.create(name:"tata", task:"todo", room:"003")
Group.create(name:"titi", task:"todo", room:"002")
Group.create(name:"toto", task:"todo", room:"001")
