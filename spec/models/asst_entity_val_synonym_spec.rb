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
require 'rails_helper'

RSpec.describe AsstEntityValSynonym, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
