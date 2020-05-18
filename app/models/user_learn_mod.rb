# frozen_string_literal: true

class UserLearnMod < ApplicationRecord
  belongs_to :user
  belongs_to :section
  belongs_to :learn_mod
end
