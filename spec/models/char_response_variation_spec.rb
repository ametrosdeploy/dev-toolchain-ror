# frozen_string_literal: true

# == Schema Information
#
# Table name: char_response_variations
#
#  id                :bigint           not null, primary key
#  response          :text
#  email_response_id :bigint           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  iteration         :integer
#  variation         :integer
#
require 'rails_helper'

RSpec.describe CharResponseVariation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
