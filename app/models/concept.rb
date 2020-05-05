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
class Concept < ApplicationRecord
    belongs_to :conceptable, polymorphic: true

    def get_synonyms
        self.synonyms = create_synonyms(self.label)
    end
end
