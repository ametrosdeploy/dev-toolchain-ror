# frozen_string_literal: true

# == Schema Information
#
# Table name: formula_sentiments
#
#  id                  :bigint           not null, primary key
#  sentiment           :integer
#  comparator          :integer
#  score               :float
#  present_cond        :boolean
#  response_formula_id :bigint           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  range_value         :float
#
require 'rails_helper'

RSpec.describe FormulaSentiment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
