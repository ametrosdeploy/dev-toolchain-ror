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
#  overall_score          :float
#  qa_condition_hit       :boolean          default(FALSE), not null
#
require 'rails_helper'

RSpec.describe UserEmailEvaluation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
