# == Schema Information
#
# Table name: characters
#
#  id                  :bigint           not null, primary key
#  age                 :integer
#  first_name          :string           not null
#  gender              :integer
#  last_name           :string
#  organizations_count :integer          default(0)
#  real_world          :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class CharacterSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper
  include DateHelper

  attributes :full_name, :gender, :real_world

  attribute :photo_url do |character|
    image_url(character.photo)
  end

  attribute :age, &:formatted_age

  attribute :created_on do |character|
    format_to_ymd(character.created_at)
  end
end
