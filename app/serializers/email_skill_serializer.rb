# frozen_string_literal: true

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
class EmailSkillSerializer
    include FastJsonapi::ObjectSerializer
    attributes :name, :email_learn_obj_id, :global_skill_id, :eval_explanation
    
  end
  
