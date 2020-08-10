class AddDebriefIdToUserEmailAssessmentItems < ActiveRecord::Migration[6.0]
  def change
    add_column :user_email_assessment_items, :debrief_id, :bigint
    add_column :user_email_assessment_items, :debrief_content, :text
    add_column :user_email_assessment_items, :debrief_variant, :integer
  end
end
