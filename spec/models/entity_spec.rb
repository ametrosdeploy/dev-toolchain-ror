# == Schema Information
#
# Table name: entities
#
#  id             :bigint           not null, primary key
#  entitable_type :string
#  label          :string
#  mandatory      :boolean          default(FALSE)
#  relevance      :integer          default(0)
#  synonyms       :text             default([]), is an Array
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  entitable_id   :bigint
#
# Indexes
#
#  index_entities_on_entitable_type_and_entitable_id  (entitable_type,entitable_id)
#
require 'rails_helper'

RSpec.describe Entity, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
