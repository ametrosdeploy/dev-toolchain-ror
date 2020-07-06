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
  Customer.new(name: 'National Bank of Armenia', email: 'customer-service@armeniabank.com').save 
  Customer.new(name: 'Sociological Institute of Lower Norway', email: 'norway@sociology.net').save
  Customer.new(name: 'Professional Ornithologist Appreciators of East Manhattan', email: 'birds@manhattan.net').save
  Customer.new(name: 'Arkwright University', email: 'info@arkwrightu.com').save
  Customer.new(name: 'Belgian Frenchologists Society', email: 'belgium@french.com').save
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

if Gender.count == 0
  Gender.create([{name: 'male'}, {name: 'female'}, {name: 'other'}])
end


# Create default characters

character = Character.where(first_name: 'Yotara', last_name: 'Fantabula').first_or_initialize
if character.new_record?
  character.first_name = 'Yotara'
  character.last_name   = 'Fantabula'
  character.age = "22"
  character.gender = Gender.order("RANDOM()").first
  character.save
end

character = Character.where(first_name: 'Entelope', last_name: 'Pertanzia').first_or_initialize
if character.new_record?
  character.first_name = 'Entelope'
  character.last_name   = 'Pertanzia'
  character.age = "32"
  character.gender = Gender.order("RANDOM()").first
  character.save
end

character = Character.where(first_name: 'Landau', last_name: 'Magulanda').first_or_initialize
if character.new_record?
  character.first_name = 'Landau'
  character.last_name   = 'Magulanda'
  character.age = "12"
  character.gender = Gender.order("RANDOM()").first
  character.save
end


# Create default worlds, organizations, and empty ELMs

world = World.where(name: 'Default World').first_or_initialize
if world.new_record?
  world.name = 'Default World'
  world.description   = 'This is a description of this world.'
  world.is_private = true 
  world.customer = Customer.order("RANDOM()").first
  world.save
end

world = World.where(name: 'Brazil 1800s').first_or_initialize
if world.new_record?
  world.name = 'Brazil 1800s'
  world.description   = 'Brazil in the 19th century.'
  world.is_private = false 
  world.save
end

world = World.where(name: 'Medieval France').first_or_initialize
if world.new_record?
  world.name = 'Medieval France'
  world.description   = 'For ELMs set in France during the medieval period.'
  world.is_private = true 
  world.customer = Customer.order("RANDOM()").first
  world.save
end

Industry.create([
    {name: 'Banking'}, {name: 'Financial Services'}, {name: 'Law'}, {name: 'Higher Education'}, {name: 'Healthcare'}
  ]  
)

GlobalSkill.create([
  {name: 'Empathy'}, {name: 'Analysis'}, {name: 'Persistence'}, {name: 'Persuasion'}, {name: 'Active Listening'}, {name: 'Information Gathering'}
]  
)

Organization.create(
  name: 'Bank of Panama', 
  description:  'A bank in Panama',
  real_world: false, 
  industry: Industry.order("RANDOM()").first
)

Organization.create(
  name: 'Delta Airlines', 
  description:  'An airline company that flies skies which are friendly.',
  real_world: true, 
  industry: Industry.order("RANDOM()").first
)

Organization.create(
  name: 'Mayflower Financial Services Inc', 
  description:  'A description of this organization goes here.',
  real_world: true, 
  industry: Industry.order("RANDOM()").first
)
  



AssessmentScheme.create(
  name: 'MCD Scheme', 
  assessment_labels_attributes: [
    {
      name: 'Mastery',
      order: 1
    },
    {
      name: 'Competent',
      order: 2
    },
    {
      name: 'Developing',
      order: 3
    }
  ]
)