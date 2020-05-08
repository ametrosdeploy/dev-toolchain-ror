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

if World.count == 0
  10.times do 
    World.new(name: Faker::Games::ElderScrolls.region, description: Faker::Marketing.buzzwords, is_private: false).save!
  end
end

if LearningModule.count == 0
  World.all.each do |world|
    world.learning_modules.build(name: Faker::Hacker.noun, abstract: Faker::Hacker.say_something_smart, time_to_complete: rand(1..12)).save!
  end
end

if EmailInteraction.count == 0
  LearningModules.all.each do |lm|
    3.times do 
      ei = EmailInteraction.new(name: "#{Faker::Books::Dune.character} email interaction", card_order: lm.last_card)
      lm.learning_objects.create(objectable: ei)
    end
  end
end