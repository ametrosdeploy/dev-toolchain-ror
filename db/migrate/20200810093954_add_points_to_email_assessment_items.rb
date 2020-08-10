class AddPointsToEmailAssessmentItems < ActiveRecord::Migration[6.0]
  def change
    add_column :email_assessment_items, :points, :integer
  end
end
