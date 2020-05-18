# frozen_string_literal: true

class UserLearnObj < ApplicationRecord
  belongs_to :user_learn_mod
  belongs_to :learning_object
end
