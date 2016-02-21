# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
User.create!(id: 1, email: 'admin@admin.com', password:"password", password_confirmation:"password")
Learner.delete_all
Group.delete_all

	Learner.create!(name: "Guillaume",notes: "random_stuffs")
	Learner.create!(name: "Sophie",notes: "random_stuffs")
	Learner.create!(name: "Jade",notes: "random_stuffs")
	Learner.create!(name: "Anas",notes: "random_stuffs")
	Learner.create!(name: "Najib",notes: "random_stuffs")
	Learner.create!(name: "Marc",notes: "random_stuffs")
	Learner.create!(name: "Antoine",notes: "random_stuffs")
	Learner.create!(name: "Thierry",notes: "random_stuffs")
	Learner.create!(name: "Anthony",notes: "random_stuffs")
	Learner.create!(name: "Thomas",notes: "random_stuffs")
	Learner.create!(name: "Vincent",notes: "random_stuffs")
	Learner.create!(name: "Alexis",notes: "random_stuffs")
	Learner.create!(name: "Julie",notes: "random_stuffs")
	Learner.create!(name: "Sabrina",notes: "random_stuffs")
	Learner.create!(name: "Bertrand",notes: "random_stuffs")
	Learner.create!(name: "Naima",notes: "random_stuffs")
	Learner.create!(name: "Othman",notes: "random_stuffs")
	Learner.create!(name: "Caroline",notes: "random_stuffs")
	Learner.create!(name: "Didier",notes: "random_stuffs")
	Learner.create!(name: "Than",notes: "random_stuffs")
	Learner.create!(name: "Manoël",notes: "random_stuffs")
Group.create(name:"Sax", task:"group", room:"003")
Group.create(name:"Tambour", task:"group", room:"002")
Group.create(name:"Guitare", task:"group", room:"001")
