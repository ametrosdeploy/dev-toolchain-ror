class CreateEmailResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :email_responses do |t|
      t.string :name

      t.timestamps
    end
  end
end
