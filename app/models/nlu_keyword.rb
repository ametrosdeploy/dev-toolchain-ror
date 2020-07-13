# frozen_string_literal: true

# == Schema Information
#
# Table name: nlu_keywords
#
#  id                 :bigint           not null, primary key
#  learning_object_id :bigint           not null
#  keyword            :string
#  relevance          :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class NluKeyword < ApplicationRecord
  # Associations ...
  belongs_to :learning_object
  has_many :formula_nlu_keywords, dependent: :destroy
end
