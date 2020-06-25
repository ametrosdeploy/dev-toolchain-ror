# frozen_string_literal: true

class KeyTopicSerializer
  include FastJsonapi::ObjectSerializer

  attribute :asst_entities do |k|
    AsstEntitySerializer.new(k.asst_entity).as_json['data']
  end
end
