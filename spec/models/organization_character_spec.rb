# == Schema Information
#
# Table name: organization_characters
#
#  id              :bigint           not null, primary key
#  character_id    :bigint           not null
#  organization_id :bigint           not null
#  world_role_id   :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe OrganizationCharacter, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
