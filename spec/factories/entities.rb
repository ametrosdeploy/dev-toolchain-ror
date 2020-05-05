# == Schema Information
#
# Table name: entities
#
#  id             :bigint           not null, primary key
#  entitable_type :string
#  label          :string
#  mandatory      :boolean
#  relevance      :integer
#  synonyms       :text             default([]), is an Array
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  entitable_id   :bigint
#
# Indexes
#
#  index_entities_on_entitable_type_and_entitable_id  (entitable_type,entitable_id)
#
FactoryBot.define do
  factory :entity do
    label { "MyString" }
    synonyms { "MyText" }
    relevance { 1 }
    mandatory { false }
  end
end
