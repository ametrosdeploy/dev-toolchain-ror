# frozen_string_literal: true

# == Schema Information
#
# Table name: test_email_evaluations
#
#  id                     :bigint           not null, primary key
#  keyword_list           :string           default([]), is an Array
#  concept_list           :string           default([]), is an Array
#  nlu_entities_list      :string           default([]), is an Array
#  joy_score              :float
#  anger_score            :float
#  disgust_score          :float
#  sadness_score          :float
#  fear_score             :float
#  asst_intent_list       :string           default([]), is an Array
#  asst_entity_value_list :integer          default([]), is an Array
#  sentiment              :string
#  sentiment_score        :float
#  user_id                :bigint           not null
#  email_learn_obj_id     :bigint           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  qa_condition_hit       :boolean          default(FALSE)
#
class TestEmailEvaluationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :keyword_list, :concept_list, :nlu_entities_list, :asst_intent_list,
             :joy_score, :anger_score, :disgust_score,
             :sadness_score, :fear_score, :sentiment, :sentiment_score

  attribute :asst_entity_value_list do |rec|
    AsstEntityValue.where(id: rec.asst_entity_value_list)&.pluck(:value)
  end
end
