class AddEmailLearnObjToEmailResponse < ActiveRecord::Migration[6.0]
  def change
    add_reference :email_responses, :email_learn_obj, null: false, foreign_key: true
  end
end
