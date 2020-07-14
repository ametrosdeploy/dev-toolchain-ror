# frozen_string_literal: true

# == Schema Information
#
# Table name: chat_learn_objs
#
#  id                      :bigint           not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  title                   :string
#  chat_character_id       :integer          is an Array
#  mentor_character_id     :integer
#  dialog_node_list        :json
#  last_skills_import_date :datetime
#

class ChatLearnObj < ApplicationRecord
    has_one :learning_object, as: :objectable
    has_one :learn_mod, through: :objectable

    attr_accessor :learn_mod_id

    def chat_character
        WorldOrgCharacter.where(id: chat_character_id)
    end

    def mentor_character
        WorldOrgCharacter.where(id: mentor_character_id)
    end

    def valid_characters
        world_char = LearnMod.find(learn_mod_id).character_ids
        errors.add(:chat_character_id, 'Invalid to character.') unless
        validate_char?(world_char, chat_character_id)
        errors.add(:mentor_character_id, 'Invalid mentor character.') unless
        validate_char?(world_char, mentor_character_id)
    end

    def validate_char?(world_char, character_ids)
        world_char.present? && (world_char & character_ids) == world_char
    end
end
