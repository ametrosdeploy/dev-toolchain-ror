# == Schema Information
#
# Table name: asst_entity_values
#
#  id             :bigint           not null, primary key
#  value          :string
#  asst_entity_id :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class AsstEntityValue < ApplicationRecord
  belongs_to :asst_entity
end
