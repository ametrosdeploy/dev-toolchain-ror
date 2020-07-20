# frozen_string_literal: true

# == Schema Information
#
# Table name: user_email_evaluations
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
#  user_learn_obj_id      :bigint           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class UserEmailEvaluation < ApplicationRecord
  # Associations ...
  belongs_to :user_learn_obj
  has_many :user_email_iterations, dependent: :destroy
  has_many :response_formula_hits, dependent: :destroy

  # Nested attributes ...
  accepts_nested_attributes_for :user_email_iterations, allow_destroy: true
end
