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
#
require 'rails_helper'

RSpec.describe UserEmailIterationResponse, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
