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
require 'rails_helper'

RSpec.describe Keyword, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
