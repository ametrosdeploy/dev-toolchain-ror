# == Schema Information
#
# Table name: chat_skills
#
#  id                        :bigint           not null, primary key
#  assistant_dialog_skill_id :integer
#  skill_name                :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
require 'rails_helper'

RSpec.describe ChatSkill, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
