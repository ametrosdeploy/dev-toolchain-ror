# == Schema Information
#
# Table name: concepts
#
#  id               :bigint           not null, primary key
#  conceptable_type :string
#  label            :string
#  mandatory        :boolean          default(FALSE)
#  relevance        :integer          default(0)
#  synonyms         :text             default([]), is an Array
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  conceptable_id   :bigint
#
# Indexes
#
#  index_concepts_on_conceptable_type_and_conceptable_id  (conceptable_type,conceptable_id)
#
class ConceptSerializer
  include FastJsonapi::ObjectSerializer
  attributes :label, :synonyms, :relevance, :mandatory

  belongs_to :example, serializer: ExampleSerializer
end
