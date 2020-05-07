# == Schema Information
#
# Table name: organizations
#
#  id               :bigint           not null, primary key
#  characters_count :integer          default(0)
#  description      :text
#  name             :string           not null
#  real_world       :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  industry_id      :bigint           not null
#
# Indexes
#
#  index_organizations_on_industry_id  (industry_id)
#
# Foreign Keys
#
#  fk_rails_...  (industry_id => industries.id)
#
class OrganizationSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper
  include DateHelper
  attributes :name, :description, :industry_id

  # has_many :characters, serializer: :character
  attribute :photo_url do |character|
    image_url(character.photo)
  end

  attribute :created_on do |world|
    format_to_ymd(world.created_at)
  end

  attribute :industry_name do |organization|
    organization.industry.try(:name)
  end
end
