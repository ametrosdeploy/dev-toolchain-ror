class TextLearnObjSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description
end
