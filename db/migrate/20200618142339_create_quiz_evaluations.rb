class CreateQuizEvaluations < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_evaluations do |t|
      t.references :user_learn_obj, null: false, foreign_key: true
      t.boolean :quiz_submitted, default: false
      t.boolean :evaluated,  default: false
      t.integer :point_type
      t.float :points
      t.references :overall_assmnt_item, foreign_key: true

      t.timestamps
    end
  end
end
