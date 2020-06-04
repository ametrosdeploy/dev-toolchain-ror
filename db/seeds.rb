# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }]
#                        )
#   Character.create(name: 'Luke', movie: movies.first)

user = User.where(email: 'ametros-admin@yopmail.com').first_or_initialize
if user.new_record?
  user.first_name = 'Admin'
  user.password   = 'admin123'
  user.save && user.add_role(:admin)
end

user = User.where(email: 'ametros-learner@yopmail.com').first_or_initialize
if user.new_record?
  user.first_name = 'Learner'
  user.password   = 'learner123'
  user.save && user.add_role(:learner)
end

user = User.where(email: 'ametros-learner1@yopmail.com').first_or_initialize
if user.new_record?
  user.first_name = 'Learner1'
  user.password   = 'learner123'
  user.save && user.add_role(:learner)
end

user = User.where(email: 'ametros-learner2@yopmail.com').first_or_initialize
if user.new_record?
  user.first_name = 'Learner2'
  user.password   = 'learner123'
  user.save && user.add_role(:learner)
end

if Customer.count.zero?
  Customer.new(name: 'Tom Steward', email: 'tom-ametros@yopmail.com').save
  Customer.new(name: 'Liam Smith', email: 'liam-ametros@yopmail.com').save
end

# Creating Dummy users for role
user = User.where(email: 'freddie-mercury@yopmail.com').first_or_initialize
if user.new_record?
  user.first_name = 'Freddie'
  user.password   = 'admin123'
  user.save && user.add_role(:sme)
end
user = User.where(email: 'sean-paul@yopmail.com').first_or_initialize
if user.new_record?
  user.first_name = 'Sean'
  user.password   = 'admin123'
  user.save && user.add_role(:sme) && user.add_role(:lead_designer)
end
user = User.where(email: 'nelly-furtado@yopmail.com').first_or_initialize
if user.new_record?
  user.first_name = 'Nelly'
  user.password   = 'admin123'
  user.save && user.add_role(:lead_designer) && user.add_role(:sme)
end
user = User.where(email: 'bob-marley@yopmail.com').first_or_initialize
if user.new_record?
  user.first_name = 'Bob'
  user.password   = 'admin123'
  user.save && user.add_role(:lead_designer)
end
