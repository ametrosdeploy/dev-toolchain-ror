# == Schema Information
#
# Table name: industries
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class IndustrySerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
end
