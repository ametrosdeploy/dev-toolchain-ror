# == Schema Information
#
# Table name: world_organizations
#
#  id              :bigint           not null, primary key
#  world_id        :bigint           not null
#  organization_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe WorldOrganization, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
