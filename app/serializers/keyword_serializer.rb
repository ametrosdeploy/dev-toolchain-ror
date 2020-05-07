class KeywordSerializer
  include FastJsonapi::ObjectSerializer
  attributes :label, :synonyms, :relevance, :keywordable_type, :keywordable, :mandatory
end
