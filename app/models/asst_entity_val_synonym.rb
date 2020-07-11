# frozen_string_literal: true

# == Schema Information
#
# Table name: asst_entity_val_synonyms
#
#  id                   :bigint           not null, primary key
#  synonym              :string
#  asst_entity_value_id :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  in_watson            :boolean          default(FALSE)
#
class AsstEntityValSynonym < ApplicationRecord
  belongs_to :asst_entity_value
end
