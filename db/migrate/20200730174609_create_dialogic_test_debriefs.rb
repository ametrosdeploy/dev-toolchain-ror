class CreateDialogicTestDebriefs < ActiveRecord::Migration[6.0]
  def change
    create_table :dialogic_test_debriefs do |t|
      t.references :dialogic_test, null: false, foreign_key: true
      t.references :key_topic, null: false, foreign_key: true
      t.references :assessment_label, foreign_key: true
      t.text :debrief_received
      t.boolean :key_topic_missed
      t.float :kt_points

      t.timestamps
    end
  end
end
