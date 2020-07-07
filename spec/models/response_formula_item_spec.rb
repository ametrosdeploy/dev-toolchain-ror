# == Schema Information
#
# Table name: response_formula_items
#
#  id                   :bigint           not null, primary key
#  response_formula_id  :bigint           not null
#  enrichment_item_type :string           not null
#  enrichment_item_id   :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  present              :boolean          default(TRUE)
#
require 'rails_helper'

RSpec.describe ResponseFormulaItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
