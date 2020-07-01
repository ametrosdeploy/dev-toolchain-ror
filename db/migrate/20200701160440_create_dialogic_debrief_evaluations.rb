class CreateDialogicDebriefEvaluations < ActiveRecord::Migration[6.0]
  def change
    create_table :dialogic_debrief_evaluations do |t|
      t.references :dialogic_evaluation, null: false, foreign_key: true
      t.references :key_topic, null: false, foreign_key: true
      t.references :assessment_label, null: false, foreign_key: true
      t.text :debrief_received

      t.timestamps
    end
  end
end
