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
require 'rails_helper'

RSpec.describe DialogicTestAnswer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
