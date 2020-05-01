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
