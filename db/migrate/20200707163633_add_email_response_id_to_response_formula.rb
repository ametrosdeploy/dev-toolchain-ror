class AddEmailResponseIdToResponseFormula < ActiveRecord::Migration[6.0]
  def change
    add_reference :response_formulas, :email_response, null: false, foreign_key: true
  end
end
