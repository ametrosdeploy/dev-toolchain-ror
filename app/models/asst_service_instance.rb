# frozen_string_literal: true

# == Schema Information
#
# Table name: asst_service_instances
#
#  id           :bigint           not null, primary key
#  learn_mod_id :bigint           not null
#  guid         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class AsstServiceInstance < ApplicationRecord
  belongs_to :learn_mod
end
