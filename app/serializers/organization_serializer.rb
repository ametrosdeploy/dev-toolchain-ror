# frozen_string_literal: true

# == Schema Information
#
# Table name: organizations
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  description      :text
#  real_world       :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  characters_count :integer          default(0)
#  industry_id      :bigint           not null
#
class OrganizationSerializer
  include FastJsonapi::ObjectSerializer
  include DateHelper
  attributes :name, :description, :industry_id

  # has_many :characters, serializer: :character
  attribute :photo_url, &:attachement_variations

  attribute :created_on do |world|
    format_to_ymd(world.created_at)
  end

  attribute :industry_name do |organization|
    organization.industry.try(:name)
  end
end
