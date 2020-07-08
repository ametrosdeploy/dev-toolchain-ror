# frozen_string_literal: true

# == Schema Information
#
# Table name: asst_assistant_shells
#
#  id                        :bigint           not null, primary key
#  assistant_dialog_skill_id :integer
#  name                      :string
#  guid                      :string
#  url                       :text
#  api_key                   :text
#  credentials_name          :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
require 'rails_helper'

RSpec.describe AsstAssistantShell, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
