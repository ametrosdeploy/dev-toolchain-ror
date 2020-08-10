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
class EmailSkill < ApplicationRecord
  has_many  :email_assessment_items

  belongs_to  :email_learn_obj
  belongs_to  :global_skill
end

