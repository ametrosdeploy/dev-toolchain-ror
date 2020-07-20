class ChangeIterationType < ActiveRecord::Migration[6.0]
  def change
    change_column :user_email_iterations, :iteration, :integer
  end
end
