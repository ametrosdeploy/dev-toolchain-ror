# frozen_string_literal: true

# == Schema Information
#
# Table name: global_skills
#
#  id               :bigint           not null, primary key
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  eval_explanation :text
#
class GlobalSkill < ApplicationRecord
  strip_attributes
end
