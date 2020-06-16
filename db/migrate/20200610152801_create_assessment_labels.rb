class CreateAssessmentLabels < ActiveRecord::Migration[6.0]
  def change
    create_table :assessment_labels do |t|
      t.string :name
      t.integer :order
      t.references :assessment_scheme, null: false, foreign_key: true

      t.timestamps
    end
  end
end
