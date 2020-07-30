# frozen_string_literal: true

# == Schema Information
#
# Table name: follow_up_questions
#
#  id                  :bigint           not null, primary key
#  question            :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  follow_up_able_type :string
#  follow_up_able_id   :bigint
#  iteration           :integer
#
require 'rails_helper'

RSpec.describe FollowUpQuestion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
