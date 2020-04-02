class LearnMod < ApplicationRecord
  # Associations ...
  belongs_to :world
  
  has_many :learn_mod_organizations
  has_many :learn_mod_contributors
  has_many :learn_mod_skills

  has_many :learn_mod_learning_objectives
  has_many :learning_objectives, through: :learn_mod_learning_objectives

end
