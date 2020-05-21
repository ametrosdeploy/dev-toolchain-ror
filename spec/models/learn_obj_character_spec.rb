# frozen_string_literal: true

# == Schema Information
#
# Table name: learn_obj_characters
#
#  id                     :bigint           not null, primary key
#  world_org_character_id :bigint           not null
#  character_type         :integer
#  learning_object_id     :bigint           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'rails_helper'

RSpec.describe LearnObjCharacter, type: :model do
end
