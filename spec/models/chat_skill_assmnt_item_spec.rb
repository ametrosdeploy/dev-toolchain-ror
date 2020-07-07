# == Schema Information
#
# Table name: chat_skill_assmnt_items
#
#  id                  :bigint           not null, primary key
#  assessment_label_id :integer
#  value_count_min     :integer
#  value_count_max     :integer
#  points              :float
#  chat_skill_id       :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require 'rails_helper'

RSpec.describe ChatSkillAssmntItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
