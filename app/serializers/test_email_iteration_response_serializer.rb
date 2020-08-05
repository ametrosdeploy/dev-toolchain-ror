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
class TestEmailIterationResponseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :response

  attribute :character do |rec|
    WorldOrgCharacterTrimmedSerializer.new(rec.character).as_json['data']
  end 
end
