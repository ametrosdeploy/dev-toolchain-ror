# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_test_answers
#
#  id                    :bigint           not null, primary key
#  dialogic_question_id  :bigint           not null
#  dialogic_test_id      :bigint           not null
#  answer                :text
#  evaluated             :boolean          default(FALSE)
#  character_response    :text
#  follow_up_question    :text
#  question_variation_id :bigint           not null
#  attempt               :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class DialogicTestAnswerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :dialogic_question_id, :dialogic_test_id,
             :answer, :evaluated, :character_response,
             :follow_up_question, :attempt

  attribute :question_variation do |dialogic_ans|
    Learner::QuestionVariationSerializer.new(dialogic_ans.question_variation)
                                        .as_json['data']
  end

  attribute :key_topic_evaluations do |ans|
    DialogicTestKtEvalSerializer.new(ans.answer_key_topic_evaluations)
                                .as_json['data']
  end
end
