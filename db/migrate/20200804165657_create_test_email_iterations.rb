class CreateTestEmailIterations < ActiveRecord::Migration[6.0]
  def change
    create_table :test_email_iterations do |t|
      t.text :email
      t.integer :iteration
      t.references :test_email_evaluation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
