# == Schema Information
#
# Table name: user_chats
#
#  id                           :bigint           not null, primary key
#  user_learn_obj_id            :integer
#  assistant_session_id         :string
#  assistant_session_json       :text
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  character_starts_interaction :boolean          default(FALSE), not null
#  overall_assmnt_item_id       :bigint
#  complete                     :boolean          default(FALSE), not null
#  skills_score_hash            :text
#  skills_missed                :text
#
class UserChat < ApplicationRecord
  belongs_to  :user_learn_obj
  has_many    :user_chat_messages, dependent: :destroy

  belongs_to :overall_assmnt_item, optional: true

  has_many    :chat_debrief_evaluations
  has_many    :chat_evaluation_skills

  serialize  :skills_score_hash, Hash
  serialize  :skills_missed, Array

  def chat_character
    WorldOrgCharacter.where(id: self.user_learn_obj.learning_object.objectable.chat_character_id).last
  end

  def mentor_character
    WorldOrgCharacter.where(id: self.user_learn_obj.learning_object.objectable.mentor_character_id).last
  end

  def data
    {
      id: id,
      created_at: created_at.strftime('%B %e, %Y')
    }
  end

end
