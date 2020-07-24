# frozen_string_literal: true

# Serializer for Adaptive Content ...
class AdaptiveContentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description
  attribute :content_details do |content|
    content.serializer_name.new(content.contentable).as_json['data']
  end
end
