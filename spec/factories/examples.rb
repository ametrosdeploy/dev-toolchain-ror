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
FactoryBot.define do
  factory :example do
    body { "MyText" }
    data { "MyString" }
  end
end
