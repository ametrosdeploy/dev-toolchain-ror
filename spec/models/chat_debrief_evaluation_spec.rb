# == Schema Information
#
# Table name: chat_debrief_evaluations
#
#  id                          :bigint           not null, primary key
#  assessment_label_id         :bigint
#  chat_skill_assmnt_item_id   :bigint
#  chat_skill_assmnt_missed_id :bigint
#  debrief_received            :text
#  assmnt_item_points          :float
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  user_chat_id                :bigint
#
require 'rails_helper'

RSpec.describe ChatDebriefEvaluation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
