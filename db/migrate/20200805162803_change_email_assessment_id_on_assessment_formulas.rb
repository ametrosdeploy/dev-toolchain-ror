class ChangeEmailAssessmentIdOnAssessmentFormulas < ActiveRecord::Migration[6.0]
  def change
    rename_column :assessment_formulas, :email_assessment_id, :email_assessment_item_id
  end
end
