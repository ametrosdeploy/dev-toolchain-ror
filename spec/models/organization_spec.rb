# == Schema Information
#
# Table name: organizations
#
#  id               :bigint           not null, primary key
#  characters_count :integer          default(0)
#  description      :text
#  name             :string           not null
#  real_world       :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  industry_id      :bigint           not null
#
# Indexes
#
#  index_organizations_on_industry_id  (industry_id)
#
# Foreign Keys
#
#  fk_rails_...  (industry_id => industries.id)
#
require 'rails_helper'

RSpec.describe Organization, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
