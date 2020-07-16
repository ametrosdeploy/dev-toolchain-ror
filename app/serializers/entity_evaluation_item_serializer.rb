# frozen_string_literal: true

# == Schema Information
#
# Table name: entity_evaluation_items
#
#  id                   :bigint           not null, primary key
#  entity_evaluation_id :bigint           not null
#  asst_entity_value_id :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class EntityEvaluationItemSerializer
  include FastJsonapi::ObjectSerializer

  attribute :asst_entity_value do |item|
    AsstEntityValueSerializer.new(item.asst_entity_value).as_json['data']
  end
end
