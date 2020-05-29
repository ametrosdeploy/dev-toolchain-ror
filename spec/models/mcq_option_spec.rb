# frozen_string_literal: true

# == Schema Information
#
# Table name: mcq_options
#
#  id               :bigint           not null, primary key
#  order            :integer
#  option           :text
#  is_correct       :boolean          default(FALSE)
#  quiz_question_id :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe McqOption, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
