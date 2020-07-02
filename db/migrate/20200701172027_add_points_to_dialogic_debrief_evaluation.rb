class AddPointsToDialogicDebriefEvaluation < ActiveRecord::Migration[6.0]
  def change
    add_column :dialogic_debrief_evaluations, :kt_points, :float
  end
end
