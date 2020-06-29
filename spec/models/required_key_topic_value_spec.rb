# frozen_string_literal: true

# == Schema Information
#
# Table name: required_key_topic_values
#
#  id                      :bigint           not null, primary key
#  dialogic_assmnt_item_id :bigint           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  key_topic_value_id      :integer
#
require 'rails_helper'

RSpec.describe RequiredKeyTopicValue, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
