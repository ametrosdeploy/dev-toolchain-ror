# == Schema Information
#
# Table name: concepts
#
#  id               :bigint           not null, primary key
#  conceptable_type :string
#  label            :string
#  mandatory        :boolean
#  relevance        :integer
#  synonyms         :text             default([]), is an Array
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  conceptable_id   :bigint
#
# Indexes
#
#  index_concepts_on_conceptable_type_and_conceptable_id  (conceptable_type,conceptable_id)
#
FactoryBot.define do
  factory :concept do
    label { "MyString" }
    synonyms { "MyText" }
    relevance { 1 }
    mandatory { false }
  end
end
