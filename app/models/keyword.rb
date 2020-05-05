# == Schema Information
#
# Table name: keywords
#
#  id               :bigint           not null, primary key
#  keywordable_type :string
#  label            :string
#  mandatory        :boolean          default(FALSE)
#  relevance        :integer          default(0)
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
    include Synonyms
    require 'synonyms'

    def get_synonyms
        self.synonyms = create_synonyms(self.label)
    end
end
