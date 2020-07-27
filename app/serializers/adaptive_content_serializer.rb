# frozen_string_literal: true

# == Schema Information
#
# Table name: adaptive_contents
#
#  id               :bigint           not null, primary key
#  title            :string
#  description      :text
#  adaptable_type   :string           not null
#  adaptable_id     :bigint           not null
#  contentable_type :string           not null
#  contentable_id   :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class AdaptiveContentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description
  attribute :content_details do |content|
    content.serializer_name.new(content.contentable).as_json['data']
  end
end
