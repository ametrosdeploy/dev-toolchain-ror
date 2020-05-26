# frozen_string_literal: true

# Serializer class for Quiz ...
class QuizLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :score_view_type
end
