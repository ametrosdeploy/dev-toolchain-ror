# frozen_string_literal: true

# == Schema Information
#
# Table name: characters
#
#  id                  :bigint           not null, primary key
#  first_name          :string           not null
#  last_name           :string
#  age                 :integer
#  gender              :integer
#  real_world          :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  organizations_count :integer          default(0)
#
class CharacterWithRoleSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper
  include DateHelper

  attributes :full_name, :first_name, :last_name, :gender_id, :real_world

  attribute :photo_url do |character|
    image_url(character.photo)
  end

  attribute :age, &:formatted_age

  attribute :created_on do |character|
    format_to_ymd(character.created_at)
  end
  attribute :role do |character|
    format_to_ymd(character.created_at)
  end
  attribute :gender, &:gender_name
end
