class AddSchemeIdToLearningObject < ActiveRecord::Migration[6.0]
  def change
    add_column :learning_objects, :overall_assessment_required,
               :boolean, default: false, null: false
    add_reference :learning_objects, :assessment_scheme, foreign_key: true
  end
end
