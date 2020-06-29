class CreateDialogicEvaluations < ActiveRecord::Migration[6.0]
  def change
    create_table :dialogic_evaluations do |t|
      t.references :user_learn_obj, null: false, foreign_key: true
      t.references :overall_assmnt_item, foreign_key: true
      t.float :overall_points
      t.integer :repeat_count

      t.timestamps
    end
  end
end
