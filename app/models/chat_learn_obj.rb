# frozen_string_literal: true

# == Schema Information
#
# Table name: chat_learn_objs
#
#  id                  :bigint           not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  title               :string
#  to_character_ids    :integer          is an Array
#  mentor_character_id :integer
#  dialog_node_list    :json
#

class ChatLearnObj < ApplicationRecord
    has_one :learning_object, as: :objectable
    has_one :learn_mod, through: :objectable  

    attr_accessor :learn_mod_id

    def to_characters
        WorldOrgCharacter.where(id: to_character_ids)
    end

    def mentor_character
        WorldOrgCharacter.where(id: mentor_character_id)
    end

    def valid_characters
        world_char = LearnMod.find(learn_mod_id).character_ids
        errors.add(:to_character_ids, 'Invalid to character.') unless
        validate_char?(world_char, to_character_ids)
        errors.add(:cc_character_ids, 'Invalid mentor character.') unless
        validate_char?(world_char, mentor_character_id)
    end

    def validate_char?(world_char, character_ids)
        world_char.present? && (world_char & character_ids) == world_char
    end
end
