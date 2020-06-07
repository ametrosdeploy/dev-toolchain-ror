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
  belongs_to :learning_object
end
