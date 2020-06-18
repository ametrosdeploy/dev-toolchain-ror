# frozen_string_literal: true

# == Schema Information
#
# Table name: asst_entities
#
#  id                 :bigint           not null, primary key
#  name               :string
#  learning_object_id :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Serializer for Asst Entity
class AsstEntitySerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :learning_object_id

  attribute :asst_entity_values do |entity|
    AsstEntityValueSerializer.new(entity.asst_entity_values).as_json['data']
  end
end
