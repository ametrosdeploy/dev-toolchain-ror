# frozen_string_literal: true

class OrganizationWithCharacterSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper
  include DateHelper
  attributes :name, :description, :industry_id

  attribute :photo_url do |character|
    image_url(character.photo)
  end

  attribute :created_on do |world|
    format_to_ymd(world.created_at)
  end

  attribute :industry_name do |organization|
    organization.industry.try(:name)
  end

  attribute :organization_characters do |organization|
    OrganizationCharacterSerializer.new(organization.organization_characters)
                                   .as_json['data']
  end
end
