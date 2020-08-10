# == Schema Information
#
# Table name: email_skills
#
#  id                 :bigint           not null, primary key
#  email_learn_obj_id :bigint
#  global_skill_id    :bigint
#  eval_explanation   :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  name               :string
#
require 'rails_helper'

RSpec.describe EmailSkill, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
