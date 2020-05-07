# == Schema Information
#
# Table name: world_roles
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class WorldRoleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
end
