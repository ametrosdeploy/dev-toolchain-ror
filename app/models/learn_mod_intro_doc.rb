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
class LearnModIntroDoc < ApplicationRecord
  belongs_to :learn_mod
  belongs_to :global_resource
end
