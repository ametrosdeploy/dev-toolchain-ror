class AddMissedToDialogicDebriefEvaluation < ActiveRecord::Migration[6.0]
  def change
    change_column :dialogic_debrief_evaluations, :assessment_label_id, :integer, null: true
    add_column :dialogic_debrief_evaluations, :key_topic_missed, :boolean, default: false
  end
end
