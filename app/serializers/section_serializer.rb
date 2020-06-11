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
class SectionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :cutomer_learn_mod_id, :customer_id, :learn_mod_id
end
