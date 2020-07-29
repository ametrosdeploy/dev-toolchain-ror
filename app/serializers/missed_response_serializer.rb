# frozen_string_literal: true

# == Schema Information
#
# Table name: missed_responses
#
#  id                    :bigint           not null, primary key
#  missed_assmnt_item_id :bigint           not null
#  response              :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  iteration             :integer
#  variation             :integer
#
class MissedResponseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :response, :iteration, :variation
end
