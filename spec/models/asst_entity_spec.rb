# frozen_string_literal: true

# == Schema Information
#
# Table name: asst_entities
#
#  id                 :bigint           not null, primary key
#  name               :string
#  learning_object_id :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require 'rails_helper'

RSpec.describe AsstEntity, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
