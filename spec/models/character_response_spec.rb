# == Schema Information
#
# Table name: character_responses
#
#  id                :bigint           not null, primary key
#  response          :text
#  email_response_id :bigint           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require 'rails_helper'

RSpec.describe CharacterResponse, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
