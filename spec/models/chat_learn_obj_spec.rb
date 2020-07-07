# frozen_string_literal: true

# == Schema Information
#
# Table name: chat_learn_objs
#
#  id                  :bigint           not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  title               :string
#  to_character_ids    :integer          is an Array
#  mentor_character_id :integer
#  dialog_node_list    :json
#
require 'rails_helper'

RSpec.describe ChatLearnObj, type: :model do
end
