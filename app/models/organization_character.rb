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
class OrganizationCharacter < ApplicationRecord
  belongs_to :character
  belongs_to :organization, counter_cache: :characters_count
  belongs_to :world_role

  validates_uniqueness_of :character_id, scope: %i[organization_id
                                                   world_role_id]

  scope :limited_org_chars, lambda { |char_list|
    where('organization_characters.character_id not in (?)', char_list)
  }
end
