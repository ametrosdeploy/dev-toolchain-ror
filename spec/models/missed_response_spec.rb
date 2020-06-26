# frozen_string_literal: true

# == Schema Information
#
# Table name: missed_responses
#
#  id                    :bigint           not null, primary key
#  missed_assmnt_item_id :bigint           not null
#  response              :text
#  follow_up             :boolean          default(FALSE)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
require 'rails_helper'

RSpec.describe MissedResponse, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
