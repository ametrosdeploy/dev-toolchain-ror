class AddNextIterationRequiredToUserEmailIteration < ActiveRecord::Migration[6.0]
  def change
    add_column :user_email_iterations, :next_iteration_required, :boolean, default: false
  end
end
