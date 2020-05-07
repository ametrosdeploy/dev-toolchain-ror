class EntitySerializer
  include FastJsonapi::ObjectSerializer
  attributes :label, :synonyms, :relevance, :entitable_type, :entitable, :mandatory
end
