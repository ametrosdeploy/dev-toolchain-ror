class CreateOverallAssmntItems < ActiveRecord::Migration[6.0]
  def change
    create_table :overall_assmnt_items do |t|
      t.float :min_score
      t.float :max_score
      t.text :feedback
      t.references :assessment_label, null: false, foreign_key: true
      t.references :learning_object, null: false, foreign_key: true

      t.timestamps
    end
  end
end
