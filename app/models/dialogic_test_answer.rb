# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_test_answers
#
#  id                    :bigint           not null, primary key
#  dialogic_question_id  :bigint           not null
#  dialogic_test_id      :bigint           not null
#  answer                :text
#  evaluated             :boolean          default(FALSE)
#  character_response    :text
#  follow_up_question    :text
#  question_variation_id :bigint           not null
#  attempt               :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class DialogicTestAnswer < ApplicationRecord
  # Associations ...
  belongs_to :dialogic_question
  belongs_to :dialogic_test
  belongs_to :question_variation
  has_many :dialogic_test_kt_evals, dependent: :destroy

  # Validations ....
  validates_presence_of :attempt
end
