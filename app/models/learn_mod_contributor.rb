class LearnModContributor < ApplicationRecord
  belongs_to :learn_mod
  belongs_to :user
  belongs_to :learn_mod_contributor_role
end
