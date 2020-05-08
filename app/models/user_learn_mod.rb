class UserLearnMod < ApplicationRecord
  belongs_to :user
  belongs_to :section
  belongs_to :learn_mod
end
