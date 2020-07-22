# frozen_string_literal: true

class NluCategorySerializer
  include FastJsonapi::ObjectSerializer
  attributes :hierarchy, :score
end
