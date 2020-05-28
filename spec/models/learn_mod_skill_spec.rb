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
require 'rails_helper'

RSpec.describe LearnModSkill, type: :model do
end
