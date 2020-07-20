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
#
class UserEmailIterationResponseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :response

  attribute :character do |rec|
    WorldOrgCharacterTrimmedSerializer.new(rec.character).as_json['data']
  end
end
