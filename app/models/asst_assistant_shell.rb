# frozen_string_literal: true

# == Schema Information
#
# Table name: asst_assistant_shells
#
#  id                        :bigint           not null, primary key
#  assistant_dialog_skill_id :integer
#  name                      :string
#  assistant_id              :string
#  url                       :text
#  api_key                   :text
#  credentials_name          :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
class AsstAssistantShell < ApplicationRecord
  belongs_to :assistant_dialog_skill
end
