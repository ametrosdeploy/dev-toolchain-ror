# == Schema Information
#
# Table name: worlds
#
#  id               :bigint           not null, primary key
#  description      :text
#  is_private       :boolean
#  learn_mods_count :integer          default(0)
#  name             :string           not null
#  world_code       :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  customer_id      :bigint           not null
#
# Indexes
#
#  index_worlds_on_customer_id  (customer_id)
#  index_worlds_on_world_code   (world_code) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#
class WorldSerializer
  include FastJsonapi::ObjectSerializer
  include DateHelper
  attributes :name, :description, :world_code, :is_private

  attribute :created_on do |world|
    format_to_ymd(world.created_at)
  end

  attribute :customer_name do |world|
    world.customer.try(:name)
  end

  attribute :customer_email do |world|
    world.customer.try(:email)
  end

  attribute :world_organizations do |world|
    WorldOrganizationSerializer.new(world.world_organizations).as_json["data"]
  end
end
