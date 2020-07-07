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
class CharacterResponse < ApplicationRecord
  # Associations ...
  belongs_to :email_response
end
