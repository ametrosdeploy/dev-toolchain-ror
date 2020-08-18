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
class TestEmailIterationResponseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :response, :is_ooto_response

  attribute :character do |rec|
    WorldOrgCharacterTrimmedSerializer.new(rec.character).as_json['data']
  end

  attribute :reason_for_qa_hit, if: proc { |record|
    record.is_ooto_response.present?
  } do |record|
    TestEmailQaConditionHitSerializer.new(record.reason_for_qa_condition_hit)
                                     .as_json['data']                      
  end
end
