# == Schema Information
#
# Table name: assistant_dialog_skills
#
#  id             :bigint           not null, primary key
#  name           :string
#  skill_id       :string
#  skillable_type :string           not null
#  skillable_id   :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class AssistantDialogSkill < ApplicationRecord
  belongs_to :skillable, polymorphic: true
end
