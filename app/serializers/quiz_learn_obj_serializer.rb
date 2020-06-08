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
#  score_view_type                     :integer          default("numeric")
#  overall_assessment_required         :boolean          default(FALSE)
#  overall_module_assessment_inclusion :boolean          default(FALSE)
#
class QuizLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :score_view_type,
             :overall_assessment_required, :overall_module_assessment_inclusion
end
