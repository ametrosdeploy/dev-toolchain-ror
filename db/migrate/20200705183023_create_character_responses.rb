class CreateCharacterResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :character_responses do |t|
      t.text :response
      t.references :email_response, null: false, foreign_key: true

      t.timestamps
    end
  end
end
