class McqOptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :order, :option, :is_correct
end
