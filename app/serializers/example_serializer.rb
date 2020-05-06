# == Schema Information
#
# Table name: examples
#
#  id         :bigint           not null, primary key
#  body       :text
#  data       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ExampleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body, :concepts, :keywords, :entities
end
