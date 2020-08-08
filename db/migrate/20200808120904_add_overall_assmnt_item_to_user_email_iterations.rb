class AddOverallAssmntItemToUserEmailIterations < ActiveRecord::Migration[6.0]
  def change
    add_column :user_email_iterations, :overall_assmnt_item_id, :bigint
  end
end
