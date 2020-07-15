class AddFieldsToEmailLearnObj < ActiveRecord::Migration[6.0]
  def change
    add_column :email_learn_objs, :iteration_enabled, :boolean, default: false
    add_column :email_learn_objs, :iteration_level, :integer
    add_column :email_learn_objs, :iteration_explanation, :text
  end
end
