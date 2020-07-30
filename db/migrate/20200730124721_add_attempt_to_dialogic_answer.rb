class AddAttemptToDialogicAnswer < ActiveRecord::Migration[6.0]
  def change
    add_column :dialogic_answers, :attempt, :integer
    remove_column :dialogic_answers, :follow_up_answer, :boolean
  end
end
