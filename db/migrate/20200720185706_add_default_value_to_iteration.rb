class AddDefaultValueToIteration < ActiveRecord::Migration[6.0]
  def change
    change_column :user_email_iterations, :iteration, :integer, default: 0
  end
end
