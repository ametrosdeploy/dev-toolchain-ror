# frozen_string_literal: true

class TextLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description
end
