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
require 'rails_helper'

RSpec.describe TestEmailIteration, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
