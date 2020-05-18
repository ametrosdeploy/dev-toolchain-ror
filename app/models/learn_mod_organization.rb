# frozen_string_literal: true

class LearnModOrganization < ApplicationRecord
  belongs_to :learn_mod
  belongs_to :world_organization
end
