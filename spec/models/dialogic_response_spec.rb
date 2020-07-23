# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_responses
#
#  id                      :bigint           not null, primary key
#  dialogic_assmnt_item_id :bigint           not null
#  response                :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  variation               :integer
#
require 'rails_helper'

RSpec.describe DialogicResponse, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
