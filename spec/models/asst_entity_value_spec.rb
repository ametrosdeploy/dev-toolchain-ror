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
require 'rails_helper'

RSpec.describe AsstEntityValue, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
