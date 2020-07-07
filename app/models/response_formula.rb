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
class ResponseFormula < ApplicationRecord
  # Associations ...
end
