# frozen_string_literal: true

class AsstIntentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description

  attribute :asst_intent_examples do |intent|
    AsstIntentExampleSerializer.new(intent.asst_intent_examples).as_json['data']
  end
end
