class CreateDialogicTests < ActiveRecord::Migration[6.0]
  def change
    create_table :dialogic_tests do |t|
      t.references :dialogic_learn_obj, null: false, foreign_key: true
      t.references :overall_assmnt_item, foreign_key: true
      t.float :overall_points
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
