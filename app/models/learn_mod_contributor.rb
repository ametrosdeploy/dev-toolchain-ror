# frozen_string_literal: true

class LearnModContributor < ApplicationRecord
  belongs_to :learn_mod_contributor_role
  belongs_to :learn_mod
  belongs_to :user
end
