# frozen_string_literal: true

# == Schema Information
#
# Table name: assistant_dialog_skills
#
#  id                 :bigint           not null, primary key
#  name               :string
#  skill_id           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  learning_object_id :bigint
#
class AssistantDialogSkill < ApplicationRecord
  # Associations ..
  belongs_to :learning_object

  # Callbacks ..
  after_destroy :remove_dialog_skill_from_watson

  # Methods ...
  def remove_dialog_skill_from_watson
    assistant_service = AssistantService.new(assistant_guid, skill_id)
    assistant_service.delete_dialog_skill
  end

  def assistant_guid
    learning_object.learn_mod.asst_service_instance.guid
  end
end
