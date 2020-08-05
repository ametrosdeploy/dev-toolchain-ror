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
#
class TestEmailEvaluation < ApplicationRecord
   # Associations ...
   belongs_to :user
   belongs_to :email_learn_obj
   has_many :test_email_iterations, dependent: :destroy
   has_many :response_formula_hits, class_name: 'TestEmailResponseFormulaHit',
                                    dependent: :destroy
 
   # Nested attributes ...
   accepts_nested_attributes_for :test_email_iterations, allow_destroy: true
end
