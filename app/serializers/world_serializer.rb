# == Schema Information
#
# Table name: worlds
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  description      :text
#  world_code       :integer          not null
#  is_private       :boolean
#  learn_mods_count :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  customer_id      :bigint           not null
#
class WorldSerializer
  include FastJsonapi::ObjectSerializer
  include DateHelper
  attributes :name, :description, :world_code, :is_private

  attribute :created_on do |world|
    format_to_ymd(world.created_at)
  end

  attribute :customer do |world|
    CustomerSerializer.new(world.customer).as_json["data"]
  end

  attribute :world_organizations do |world|
    WorldOrganizationSerializer.new(world.world_organizations).as_json["data"]
  end
end
