# frozen_string_literal: true

# == Schema Information
#
# Table name: test_email_iteration_responses
#
#  id                      :bigint           not null, primary key
#  test_email_iteration_id :bigint           not null
#  response                :text
#  character_id            :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  is_ooto_response        :boolean          default(FALSE)
#
class TestEmailIterationResponse < ApplicationRecord
  # Associations ...
  belongs_to :test_email_iteration
  belongs_to :character, class_name: 'WorldOrgCharacter'

  # Methods ...
  def reason_for_qa_condition_hit
    return if is_ooto_response.blank?

    email_lo = test_email_iteration.test_email_evaluation
                                   .email_learn_obj
    qa_condition = email_lo.qa_condition_for(character_id)
    test_email_iteration.qa_condition_hits.find_by(
      qa_condition_id: qa_condition.id
    )
  end
end
