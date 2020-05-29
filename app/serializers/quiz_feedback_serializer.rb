# frozen_string_literal: true

# Serializer for Quiz question feedbacks ...
class QuizFeedbackSerializer
  include FastJsonapi::ObjectSerializer
  attributes :right_ans_feedback, :wrong_ans_feedback
end
