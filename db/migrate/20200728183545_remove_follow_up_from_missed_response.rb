# frozen_string_literal: true

# Migration to remove follow up from missed_responses ...
class RemoveFollowUpFromMissedResponse < ActiveRecord::Migration[6.0]
  def change
    remove_column :missed_responses, :follow_up, :boolean
  end
end
