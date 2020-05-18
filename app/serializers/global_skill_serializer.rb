# frozen_string_literal: true

class GlobalSkillSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
end
