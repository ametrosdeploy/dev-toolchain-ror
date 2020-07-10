# frozen_string_literal: true

# == Schema Information
#
# Table name: entity_evaluations
#
#  id               :bigint           not null, primary key
#  condition        :text
#  quiz_question_id :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class EntityEvaluationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :quiz_question_id, :condition

  attributes :entity_evaluation_items do |eval|
    EntityEvaluationItemSerializer.new(eval.entity_evaluation_items).as_json['data']
  end
end
