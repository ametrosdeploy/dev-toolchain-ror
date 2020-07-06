# frozen_string_literal: true

# == Schema Information
#
# Table name: nlu_entities
#
#  id                 :bigint           not null, primary key
#  learning_object_id :bigint           not null
#  entity             :string
#  entity_type        :string
#  score              :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require 'rails_helper'

RSpec.describe NluEntity, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
