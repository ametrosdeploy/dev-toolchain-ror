# frozen_string_literal: true

# == Schema Information
#
# Table name: nlu_sentiments
#
#  id                 :bigint           not null, primary key
#  learning_object_id :bigint           not null
#  sentiment          :integer
#  score              :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  from_ideal_input   :boolean
#
class NluSentiment < ApplicationRecord
  # Associations ...
  belongs_to :learning_object
  has_many :response_formula_items, as: :enrichment_item

  # Enums ...
  enum sentiment: %i[positive negative]
end
