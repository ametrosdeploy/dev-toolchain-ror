# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_learn_objs
#
#  id                                  :bigint           not null, primary key
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  title                               :string
#  description                         :text
#  score_view_type                     :integer          default("numeric"),
#  not null
#  overall_module_assessment_inclusion :boolean          default(FALSE), not
#  null
#
class QuizLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  # Removed :title, :description as we already have these keys in
  # learning_objects table
  attributes :score_view_type, :overall_module_assessment_inclusion
end
