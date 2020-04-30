class WorldSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :world_code, :is_private
  include DateHelper

  attribute :created_on do |world|
    format_to_ymd(world.created_at)
  end

  attribute :customer_name do |world|
    world.customer.try(:name)
  end
end
