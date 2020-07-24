# frozen_string_literal: true

# == Schema Information
#
# Table name: interstitial_contents
#
#  id                 :bigint           not null, primary key
#  email_learn_obj_id :bigint           not null
#  content_order      :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  occupiable_type    :string           not null
#  occupiable_id      :bigint           not null
#
# InterstitialContent Serializer ...
class InterstitialContentSerializer
  include FastJsonapi::ObjectSerializer

  attribute :content_details do |content|
    content.serializer_name.new(content.occupiable).as_json['data']
  end
end
