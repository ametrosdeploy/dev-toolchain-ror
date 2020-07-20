class CreateUserEmailIterations < ActiveRecord::Migration[6.0]
  def change
    create_table :user_email_iterations do |t|
      t.text :email
      t.float :iteration
      t.text :response
      t.references :user_email_evaluation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
