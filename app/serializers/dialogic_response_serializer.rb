# frozen_string_literal: true

# == Schema Information
#
# Table name: dialogic_responses
#
#  id                      :bigint           not null, primary key
#  dialogic_assmnt_item_id :bigint           not null
#  response                :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  variation               :integer
#
class DialogicResponseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :response, :variation
end
