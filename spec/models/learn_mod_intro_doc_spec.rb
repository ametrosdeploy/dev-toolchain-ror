# frozen_string_literal: true

# == Schema Information
#
# Table name: learn_mod_intro_docs
#
#  id                 :bigint           not null, primary key
#  learn_mod_id       :bigint           not null
#  global_resource_id :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require 'rails_helper'

RSpec.describe LearnModIntroDoc, type: :model do
end
