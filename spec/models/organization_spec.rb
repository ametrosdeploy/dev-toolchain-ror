# == Schema Information
#
# Table name: organizations
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  description      :text
#  real_world       :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  characters_count :integer          default(0)
#  industry_id      :bigint           not null
#
require 'rails_helper'

RSpec.describe Organization, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
