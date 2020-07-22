# frozen_string_literal: true

# == Schema Information
#
# Table name: chat_learn_objs
#
#  id                      :bigint           not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  title                   :string
#  mentor_character_id     :integer
#  dialog_node_list        :json
#  last_skills_import_date :datetime
#  chat_character_id       :integer
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

    def assistant_dialog_skill 
        AssistantDialogSkill.find(self.learning_object.assistant_dialog_skill.id)
    end

    def asst_assistant_shell
        shell = self.learning_object.assistant_dialog_skill.asst_assistant_shell
        if shell.blank?
            return nil 
        else  
            AsstAssistantShell.find(self.learning_object.assistant_dialog_skill.asst_assistant_shell.id)
        end
    end

    def valid_characters
        world_char = LearnMod.find(learn_mod_id).character_ids
        errors.add(:chat_character_id, 'Invalid chat character.') unless
        validate_char?(world_char, chat_character_id)
        errors.add(:mentor_character_id, 'Invalid mentor character.') unless
        validate_char?(world_char, mentor_character_id)
    end

    def validate_char?(world_char, character_ids)
        world_char.present? && (world_char & character_ids) == world_char
    end
end
