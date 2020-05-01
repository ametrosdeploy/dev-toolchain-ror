# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.where(email: "ametros-admin@yopmail.com").first_or_initialize
if user.new_record?
  user.first_name = "Admin"
  user.password   = "admin123"
  user.save && user.add_role(:admin)
end

if Customer.count == 0
  Customer.new(name:"Anu Sirohi", email: "anu.sirohi@yopmail.com" ).save
  Customer.new(name:"Sam Sirohi", email: "sam.sirohi@yopmail.com" ).save
end

if Industry.count == 0
  Industry.new(name: "Aerospace").save
  Industry.new(name: "Education").save
  Industry.new(name: "Transport").save
end