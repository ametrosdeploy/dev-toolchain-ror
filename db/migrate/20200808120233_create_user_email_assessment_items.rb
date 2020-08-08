class CreateUserEmailAssessmentItems < ActiveRecord::Migration[6.0]
  def change
    create_table :user_email_assessment_items do |t|
      t.bigint :email_assessment_item_id

      t.timestamps
    end
  end
end
