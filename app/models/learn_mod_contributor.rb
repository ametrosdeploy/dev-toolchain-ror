# frozen_string_literal: true

# == Schema Information
#
# Table name: learn_mod_contributors
#
#  id                            :bigint           not null, primary key
#  learn_mod_contributor_role_id :bigint           not null
#  learn_mod_id                  :bigint           not null
#  user_id                       :bigint           not null
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#
class LearnModContributor < ApplicationRecord
  belongs_to :learn_mod_contributor_role
  belongs_to :learn_mod
  belongs_to :user
end
