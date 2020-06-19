# frozen_string_literal: true

module Learner
  # McqOption serializer for learner
  class McqOptionSerializer
    include FastJsonapi::ObjectSerializer
    attributes :order, :option
  end
end
