class OrganizationCharacter < ApplicationRecord
  enum character_role: [:admin, :lab_assitant, :operator, :chat_admin ]
  belongs_to :character
  belongs_to :organization
end
