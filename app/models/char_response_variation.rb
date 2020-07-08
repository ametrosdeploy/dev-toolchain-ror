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
#
class CharResponseVariation < ApplicationRecord
  # Associations ...
  belongs_to :email_response
end
