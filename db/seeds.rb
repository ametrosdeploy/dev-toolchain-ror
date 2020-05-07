# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

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

if Character.count == 0
  10.times do
    first_name = Faker::Name.name.split(' ')[0]
    last_name = Faker::Name.name.split(' ')[1]
    Character.new(first_name: first_name, last_name: last_name, age: rand(20..50), gender: rand(0..2), real_world: false).save
  end
end

if Industry.count == 0
  10.times do
    Industry.new(name: Faker::IndustrySegments.industry).save!
  end
end

if Organization.count == 0
  10.times do 
    Organization.new(name: Faker::Company.name, description: Faker::Company.bs, real_world: false, industry_id: Industry.order(Arel.sql('RANDOM()')).first.id).save
  end
end