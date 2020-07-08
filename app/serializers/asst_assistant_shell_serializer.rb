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
class AsstAssistantShellSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :assistant_dialog_skill_id, :guid, :url, :api_key, :credentials_name

  attribute :created_on do |character|
    format_to_ymd(character.created_at)
  end

  attribute :gender, &:gender_name
  end
