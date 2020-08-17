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
class UserEmailIterationResponseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :response, :is_ooto_response

  attribute :character do |rec|
    WorldOrgCharacterTrimmedSerializer.new(rec.character).as_json['data']
  end
end
