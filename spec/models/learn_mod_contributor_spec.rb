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
require 'rails_helper'

RSpec.describe LearnModContributor, type: :model do
end
