class LearningObject < ApplicationRecord
  belongs_to :learn_mod
  belongs_to :objectable, polymorphic: true
end
