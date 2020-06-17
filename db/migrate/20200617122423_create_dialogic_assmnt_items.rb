class CreateDialogicAssmntItems < ActiveRecord::Migration[6.0]
  def change
    create_table :dialogic_assmnt_items do |t|
      t.references :key_topic, null: false, foreign_key: true
      t.references :assessment_label, null: false, foreign_key: true
      t.integer :value_count_min
      t.integer :value_count_max
      t.float :points

      t.timestamps
    end
  end
end
