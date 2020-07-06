class AddColumnCompleteToDialogicEvaluations < ActiveRecord::Migration[6.0]
  def change
    add_column :dialogic_evaluations, :complete, :boolean, default: false
    change_column :dialogic_evaluations, :repeat_count, :integer, default: 0
    # add_column :dialogic_debrief_evaluations, :dialogic_answer_id, :integer,
    #            null: false

  end
end
