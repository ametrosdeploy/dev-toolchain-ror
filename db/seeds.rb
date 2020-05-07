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
  Customer.new(name:"Tom Steward", email: "tom-ametros@yopmail.com" ).save
  Customer.new(name:"Liam Smith", email: "liam-ametros@yopmail.com" ).save
end

if Example.count == 0
  5.times do |i|
    example = Example.create(body: "As the constituent services are small, they can be built by one or more small teams from the beginning separated by service boundaries which make it easier to scale up the development effort if need be. Once developed, these services can also be deployed independently of each other and hence its easy to identify hot services and scale them independent of whole application. Microservices also offer improved fault isolation whereby in the case of an error in one service the whole application doesn’t necessarily stop functioning. When the error is fixed, it can be deployed only for the respective service instead of redeploying an entire application. Another advantage which a microservices architecture brings to the table is making it easier to choose the technology stack (programming languages, databases, etc.) which is best suited for the required functionality (service) instead of being required to take a more standardized, one-size-fits-all approach.")
    example.set_data
    example.create_all if example.save!
  end
end