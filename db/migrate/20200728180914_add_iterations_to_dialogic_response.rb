class AddIterationsToDialogicResponse < ActiveRecord::Migration[6.0]
  def change
    add_column :dialogic_responses, :iteration, :integer
  end
end
