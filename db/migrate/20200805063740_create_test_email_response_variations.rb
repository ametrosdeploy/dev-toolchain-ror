class CreateTestEmailResponseVariations < ActiveRecord::Migration[6.0]
  def change
    create_table :test_email_response_variations do |t|
      t.references :test_email_iteration, null: false, foreign_key: true
      t.references :char_response_variation, null: false, foreign_key: true, index: { name: :test_response_variation_index }

      t.timestamps
    end
  end
end
