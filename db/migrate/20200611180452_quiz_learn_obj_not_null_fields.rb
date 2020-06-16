class QuizLearnObjNotNullFields < ActiveRecord::Migration[6.0]
  def change
    change_column :quiz_learn_objs, :score_view_type, :integer, default: 0, null: false
    change_column :quiz_learn_objs, :overall_module_assessment_inclusion, :boolean, default: false, null: false
  end
end
