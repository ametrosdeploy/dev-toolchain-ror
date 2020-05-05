class CustomerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email
end
