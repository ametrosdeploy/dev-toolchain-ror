# frozen_string_literal: true

# == Schema Information
#
# Table name: chat_skill_assmnt_misseds
#
#  id            :bigint           not null, primary key
#  chat_skill_id :integer
#  points        :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class ChatSkillAssmntMissed < ApplicationRecord
  belongs_to :chat_skill
  has_many :debriefs, as: :debriefable
  has_many :adaptive_contents, as: :adaptable, dependent: :destroy

  accepts_nested_attributes_for :debriefs, allow_destroy: true
end
