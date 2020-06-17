# frozen_string_literal: true

# DialogicResponse Migration ...
class CreateDialogicResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :dialogic_responses do |t|
      t.references :dialogic_assmnt_item, null: false, foreign_key: true
      t.text :response

      t.timestamps
    end
  end
end
