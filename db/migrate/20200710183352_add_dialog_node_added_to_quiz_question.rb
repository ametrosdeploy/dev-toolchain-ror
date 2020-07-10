class AddDialogNodeAddedToQuizQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :quiz_questions, :dialog_node_added, :boolean, default: false
  end
end
