# == Schema Information
#
# Table name: chat_skills
#
#  id                        :bigint           not null, primary key
#  assistant_dialog_skill_id :integer
#  name                      :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
class ChatSkill < ApplicationRecord
    belongs_to  :assistant_dialog_skill
end
