# frozen_string_literal: true

# == Schema Information
#
# Table name: entity_evaluation_items
#
#  id                   :bigint           not null, primary key
#  entity_evaluation_id :bigint           not null
#  asst_entity_value_id :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
require 'rails_helper'

RSpec.describe EntityEvaluationItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
