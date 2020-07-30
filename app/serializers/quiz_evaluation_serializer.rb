# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_evaluations
#
#  id                     :bigint           not null, primary key
#  user_learn_obj_id      :bigint           not null
#  quiz_submitted         :boolean          default(FALSE)
#  evaluated              :boolean          default(FALSE)
#  point_type             :integer
#  points                 :float
#  overall_assmnt_item_id :bigint
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  quiz_complete          :boolean          default(FALSE)
#  question_order_ids     :integer          default([]), is an Array
#
class QuizEvaluationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_learn_obj_id, :quiz_submitted, :evaluated, :point_type,
             :points, :overall_message, :tally_message, :watson_response

  attribute :quiz_responses do |evaluation|
    QuizResponseSerializer.new(evaluation.quiz_responses)
                          .as_json['data']
  end

  attribute :overall_assmnt_item do |evaluation|
    OverallAssmntItemSerializer.new(evaluation.overall_assmnt_item)
                               .as_json['data']
  end
end
