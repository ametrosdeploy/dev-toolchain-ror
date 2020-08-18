class AddIsOotoResponseToTestEmailIterationResponse < ActiveRecord::Migration[6.0]
  def change
    add_column :test_email_iteration_responses, :is_ooto_response, :boolean, default: false
  end
end
