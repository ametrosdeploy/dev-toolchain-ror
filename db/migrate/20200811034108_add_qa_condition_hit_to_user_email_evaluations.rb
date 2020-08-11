class AddQaConditionHitToUserEmailEvaluations < ActiveRecord::Migration[6.0]
  def change
    add_column :user_email_evaluations, :qa_condition_hit, :boolean, default: false, null: false
  end
end
