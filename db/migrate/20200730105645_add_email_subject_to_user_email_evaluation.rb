class AddEmailSubjectToUserEmailEvaluation < ActiveRecord::Migration[6.0]
  def change
    add_column :user_email_evaluations, :email_subject, :string
  end
end
