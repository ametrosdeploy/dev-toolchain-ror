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
require 'rails_helper'

RSpec.describe QuizQuestion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
