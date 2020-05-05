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
require 'rails_helper'

RSpec.describe Concept, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
