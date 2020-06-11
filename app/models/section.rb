# frozen_string_literal: true

# == Schema Information
#
# Table name: sections
#
#  id                   :bigint           not null, primary key
#  cutomer_learn_mod_id :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Section < ApplicationRecord
  belongs_to :cutomer_learn_mod

  delegate :customer_id, :learn_mod_id, :detached,
           to: :cutomer_learn_mod, prefix: false, allow_nil: true

  accepts_nested_attributes_for :cutomer_learn_mod
end
