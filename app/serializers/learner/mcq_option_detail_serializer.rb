# frozen_string_literal: true

module Learner
  # McqOption serializer for learner with is_correct
  class McqOptionDetailSerializer
    include FastJsonapi::ObjectSerializer
    attributes attributes :order, :option, :is_correct
  end
end
