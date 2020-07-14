# frozen_string_literal: true

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

class ChatSkillSerializer
    include FastJsonapi::ObjectSerializer
    attributes :assistant_dialog_skill_id, :name
end
  
