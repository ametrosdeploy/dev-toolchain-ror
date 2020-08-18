# frozen_string_literal: true

# == Schema Information
#
# Table name: user_email_iteration_responses
#
#  id                      :bigint           not null, primary key
#  user_email_iteration_id :bigint           not null
#  response                :text
#  character_id            :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  is_ooto_response        :boolean          default(FALSE)
#
class UserEmailIterationResponse < ApplicationRecord
  # Associations ...
  belongs_to :user_email_iteration
  belongs_to :character, class_name: 'WorldOrgCharacter'
end
