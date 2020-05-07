# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CustomerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email
end
