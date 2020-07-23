# frozen_string_literal: true

# InterstitialContent Serializer ...
class InterstitialContentSerializer
  include FastJsonapi::ObjectSerializer

  attribute :content_details do |content|
    content.serializer_name.new(content.occupiable).as_json['data']
  end
end
