# == Schema Information
#
# Table name: response_formulas
#
#  id               :bigint           not null, primary key
#  formula          :string
#  keywords_minimum :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe ResponseFormula, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
