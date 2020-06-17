# frozen_string_literal: true

# Serializer for AsstEntityValue
class AsstEntityValueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :value, :asst_entity_id

  attribute :asst_entity_val_synonyms do |entity_val|
    AsstEntityValSynonymSerializer.new(entity_val.asst_entity_val_synonyms).as_json['data']
  end
end
