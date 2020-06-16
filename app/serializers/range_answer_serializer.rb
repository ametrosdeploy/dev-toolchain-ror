# frozen_string_literal: true

class RangeAnswerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :low_range, :high_range
end
