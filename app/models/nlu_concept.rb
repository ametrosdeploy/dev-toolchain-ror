# frozen_string_literal: true

# == Schema Information
#
# Table name: nlu_concepts
#
#  id                 :bigint           not null, primary key
#  learning_object_id :bigint           not null
#  concept            :string
#  score              :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class NluConcept < ApplicationRecord
  # Associations ...
  belongs_to :learning_object
end
