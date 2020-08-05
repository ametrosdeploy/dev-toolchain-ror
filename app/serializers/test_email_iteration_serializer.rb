# == Schema Information
#
# Table name: test_email_iterations
#
#  id                       :bigint           not null, primary key
#  email                    :text
#  iteration                :integer
#  test_email_evaluation_id :bigint           not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class TestEmailIterationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email

  attribute :responses do |rec|
    TestEmailIterationResponseSerializer.new(rec.user_email_iteration_responses).as_json['data']
  end
end
