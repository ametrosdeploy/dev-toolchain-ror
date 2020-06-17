# frozen_string_literal: true

class NumericAnswerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :answer
end
