class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :email
end
