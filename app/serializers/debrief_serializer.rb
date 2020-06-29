# frozen_string_literal: true

class DebriefSerializer
  include FastJsonapi::ObjectSerializer
  attributes :content
end
