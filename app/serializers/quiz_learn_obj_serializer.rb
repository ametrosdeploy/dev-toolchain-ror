# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_learn_objs
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  title           :string
#  description     :text
#  score_view_type :integer          default("numeric")
#
# Serializer class for Quiz ...
class QuizLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :score_view_type
end
