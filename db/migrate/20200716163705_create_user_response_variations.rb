class CreateUserResponseVariations < ActiveRecord::Migration[6.0]
  def change
    create_table :user_response_variations do |t|
      t.references :user_email_iteration, null: false, foreign_key: true
      t.references :char_response_variation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
