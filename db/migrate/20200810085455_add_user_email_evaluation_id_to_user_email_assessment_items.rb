class AddUserEmailEvaluationIdToUserEmailAssessmentItems < ActiveRecord::Migration[6.0]
  def change
    add_column :user_email_assessment_items, :user_email_evaluation_id, :bigint
  end
end
