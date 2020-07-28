class AddIterationsToMissedResponse < ActiveRecord::Migration[6.0]
  def change
    add_column :missed_responses, :iteration, :integer
    add_column :missed_responses, :variation, :integer
  end
end
