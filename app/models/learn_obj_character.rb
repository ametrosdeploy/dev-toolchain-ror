# frozen_string_literal: true

class LearnObjCharacter < ApplicationRecord
  belongs_to :world_org_character
  belongs_to :learning_object
end
