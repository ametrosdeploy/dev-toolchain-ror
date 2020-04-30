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
