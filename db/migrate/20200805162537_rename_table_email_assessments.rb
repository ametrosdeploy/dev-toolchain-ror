class RenameTableEmailAssessments < ActiveRecord::Migration[6.0]
  def change
    rename_table :email_assessments, :email_assessment_items
  end
end
