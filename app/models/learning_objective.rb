class LearningObjective < ApplicationRecord
  has_many :learn_mod_learning_objectives
  has_many :learn_mods, through: :learn_mod_learning_objectives
end
