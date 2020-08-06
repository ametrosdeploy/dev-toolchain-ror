class CreateEmailAssessments < ActiveRecord::Migration[6.0]
  def change
    create_table :email_assessments do |t|
      t.integer :email_skill_id
      t.integer :assessment_label_id

      t.timestamps
    end
  end
end
