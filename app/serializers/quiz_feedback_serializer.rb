class QuizFeedbackSerializer
  include FastJsonapi::ObjectSerializer
  attributes :right_ans_feedback, :wrong_ans_feedback
end
