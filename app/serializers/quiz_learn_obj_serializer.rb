class QuizLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :score_view_type
end
