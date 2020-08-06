class CreateAssessmentFormulas < ActiveRecord::Migration[6.0]
  def change
    create_table :assessment_formulas do |t|
      t.string :formula
      t.integer :email_assessment_id
      t.integer :present_cond_keyword_min
      t.integer :absent_cond_keyword_min
      t.boolean :sentiment_enabled, default: true, null: true
      t.boolean :emotion_enabled, default: true, null: true

      t.timestamps
    end
  end
end
