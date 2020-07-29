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
class MissedResponse < ApplicationRecord
  # Associations ...
  belongs_to :missed_assmnt_item

  # Validations ...
  validates :iteration, :variation, :response, presence: true
  validates :iteration, inclusion: { in: [1, 2, 3, 4], message:
    'Valid Response iterations are from 1 to 4' }
end
