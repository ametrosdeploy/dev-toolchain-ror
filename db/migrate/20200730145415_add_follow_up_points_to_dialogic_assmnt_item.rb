class AddFollowUpPointsToDialogicAssmntItem < ActiveRecord::Migration[6.0]
  def change
    add_column :dialogic_assmnt_items, :follow_up_points, :float
    remove_column :follow_up_questions, :points
  end
end
