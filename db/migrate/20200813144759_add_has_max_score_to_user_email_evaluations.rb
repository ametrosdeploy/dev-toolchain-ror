class AddHasMaxScoreToUserEmailEvaluations < ActiveRecord::Migration[6.0]
  def change
    add_column :user_email_evaluations, :has_max_score, :boolean, default: false
  end
end
