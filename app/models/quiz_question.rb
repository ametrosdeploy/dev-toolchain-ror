# == Schema Information
#
# Table name: quiz_questions
#
#  id                   :bigint           not null, primary key
#  question             :text
#  type                 :integer
#  points               :integer
#  order                :integer
#  feedback_from_watson :boolean          default(FALSE)
#  quiz_learn_obj_id    :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class QuizQuestion < ApplicationRecord
  enum type: %i[multiple_choice numeric range long_answer]
  belongs_to :quiz_learn_obj
end
