# frozen_string_literal: true

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
class OrganizationCharacterSerializer
  include FastJsonapi::ObjectSerializer
  attributes :world_role_id, :character_id, :organization_id

  attribute :world_role do |organization_character|
    WorldRoleSerializer.new(organization_character.world_role).as_json['data']
  end

  attribute :characters do |organization_character|
    CharacterSerializer.new(organization_character.character).as_json['data']
  end
end
