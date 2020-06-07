# frozen_string_literal: true

# Serializer for AsstEntityValSynonym
class AsstEntityValSynonymSerializer
  include FastJsonapi::ObjectSerializer
  attributes :synonym, :asst_entity_value_id
end
