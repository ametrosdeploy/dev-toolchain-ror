class QuizQuestionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :question, :question_type, :points, :feedback_from_watson, :quiz_learn_obj_id
end
