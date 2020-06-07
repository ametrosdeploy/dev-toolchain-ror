# frozen_string_literal: true

# Serializer for Asst Entity
class AsstEntitySerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :learning_object_id

  attribute :asst_entity_values do |entity|
    AsstEntityValueSerializer.new(entity.asst_entity_values).as_json['data']
  end
end
