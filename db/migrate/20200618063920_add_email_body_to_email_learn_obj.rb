class AddEmailBodyToEmailLearnObj < ActiveRecord::Migration[6.0]
  def change
    add_column :email_learn_objs, :email_body, :text
    add_column :user_sections, :complete_percentage, :integer, default: 0
  end
end
