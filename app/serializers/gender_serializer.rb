# frozen_string_literal: true

class GenderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
end
