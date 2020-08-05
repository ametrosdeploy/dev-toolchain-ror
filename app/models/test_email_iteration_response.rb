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
#
class TestEmailIterationResponse < ApplicationRecord
  # Associations ...
  belongs_to :test_email_iteration
  belongs_to :character, class_name: 'WorldOrgCharacter'
end
