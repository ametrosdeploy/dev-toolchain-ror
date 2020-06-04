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
require 'rails_helper'

RSpec.describe AssistantDialogSkill, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
