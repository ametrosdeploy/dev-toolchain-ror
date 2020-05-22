# frozen_string_literal: true

# == Schema Information
#
# Table name: world_org_characters
#
#  id                    :bigint           not null, primary key
#  world_organization_id :bigint           not null
#  character_id          :bigint           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  world_role_id         :bigint           not null
#
require 'rails_helper'

RSpec.describe WorldOrgCharacter, type: :model do
end
