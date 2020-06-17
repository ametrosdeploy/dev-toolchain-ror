# frozen_string_literal: true

# == Schema Information
#
# Table name: asst_intents
#
#  id                 :bigint           not null, primary key
#  name               :string
#  description        :text
#  learning_object_id :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require 'rails_helper'

RSpec.describe AsstIntent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
