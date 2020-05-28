# frozen_string_literal: true

# == Schema Information
#
# Table name: learn_mod_learning_objectives
#
#  id                    :bigint           not null, primary key
#  learn_mod_id          :bigint           not null
#  learning_objective_id :bigint           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class LearnModLearningObjective < ApplicationRecord
  belongs_to :learn_mod
  belongs_to :learning_objective
end
