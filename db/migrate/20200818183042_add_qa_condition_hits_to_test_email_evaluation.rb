class AddQaConditionHitsToTestEmailEvaluation < ActiveRecord::Migration[6.0]
  def change
    add_column :test_email_evaluations, :qa_condition_hit, :boolean, default: false
  end
end
