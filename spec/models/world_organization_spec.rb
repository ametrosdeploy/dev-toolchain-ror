# == Schema Information
#
# Table name: world_organizations
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#  world_id        :bigint           not null
#
# Indexes
#
#  index_world_organizations_on_organization_id  (organization_id)
#  index_world_organizations_on_world_id         (world_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (world_id => worlds.id)
#
require 'rails_helper'

RSpec.describe WorldOrganization, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
