class RemoveQaConditionHitFromUserEmailIteration < ActiveRecord::Migration[6.0]
  def change
    remove_column :user_email_iterations, :qa_condition_hit, :boolean
  end
end
