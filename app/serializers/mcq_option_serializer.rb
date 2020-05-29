# frozen_string_literal: true

# Serializer for Mcq Options ...
class McqOptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :order, :option, :is_correct
end
