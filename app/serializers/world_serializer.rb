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
