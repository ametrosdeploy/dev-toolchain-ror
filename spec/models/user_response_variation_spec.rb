# frozen_string_literal: true

# == Schema Information
#
# Table name: user_response_variations
#
#  id                         :bigint           not null, primary key
#  user_email_iteration_id    :bigint           not null
#  char_response_variation_id :bigint           not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
require 'rails_helper'

RSpec.describe UserResponseVariation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
