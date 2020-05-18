# frozen_string_literal: true

class LearnModSkill < ApplicationRecord
  belongs_to :learn_mod
  belongs_to :global_skill
end
