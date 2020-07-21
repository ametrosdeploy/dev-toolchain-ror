class CreateUserEmailIterationResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :user_email_iteration_responses do |t|
      t.references :user_email_iteration, null: false, foreign_key: true
      t.text :response
      t.integer :character_id

      t.timestamps
    end
  end
end
