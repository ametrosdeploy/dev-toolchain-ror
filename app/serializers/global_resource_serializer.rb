class GlobalResourceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :resource_type, :customer_id, :private
end
