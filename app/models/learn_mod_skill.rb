# frozen_string_literal: true

# == Schema Information
#
# Table name: learn_mod_skills
#
#  id              :bigint           not null, primary key
#  learn_mod_id    :bigint           not null
#  global_skill_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class LearnModSkill < ApplicationRecord
  belongs_to :learn_mod
  belongs_to :global_skill
end
