# frozen_string_literal: true

# == Schema Information
#
# Table name: email_responses
#
#  id                 :bigint           not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  email_learn_obj_id :bigint           not null
#  character_id       :integer
#
class EmailResponse < ApplicationRecord
  # Associations ...
  has_many :char_response_variations
  has_many :response_formulas
  belongs_to :character, class_name: 'WorldOrgCharacter'

  # Nested attributes ...
  accepts_nested_attributes_for :char_response_variations, allow_destroy: true
  accepts_nested_attributes_for :response_formulas, allow_destroy: true

  # Methods ...
  def random_char_response_variation_for(itr)
    char_responses = char_response_variations.where(iteration: itr)
    random_index = rand(char_responses.count)
    char_responses[random_index]
  end
end
