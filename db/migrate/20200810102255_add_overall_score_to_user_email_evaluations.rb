class AddOverallScoreToUserEmailEvaluations < ActiveRecord::Migration[6.0]
  def change
    add_column :user_email_evaluations, :overall_score, :float
  end
end
