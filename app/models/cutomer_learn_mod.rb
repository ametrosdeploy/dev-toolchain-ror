# frozen_string_literal: true

class CutomerLearnMod < ApplicationRecord
  belongs_to :customer
  belongs_to :learn_mod
end
