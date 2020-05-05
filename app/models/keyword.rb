# == Schema Information
#
# Table name: keywords
#
#  id               :bigint           not null, primary key
#  keywordable_type :string
#  label            :string
#  mandatory        :boolean
#  relevance        :integer
#  synonyms         :text             default([]), is an Array
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  keywordable_id   :bigint
#
# Indexes
#
#  index_keywords_on_keywordable_type_and_keywordable_id  (keywordable_type,keywordable_id)
#
class Keyword < ApplicationRecord
    belongs_to :keywordable, polymorphic: true

    def get_synonyms
        self.synonyms = create_synonyms(self.label)
    end
end
