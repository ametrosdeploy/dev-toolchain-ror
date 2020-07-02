class AddAdminNotesToLearningObject < ActiveRecord::Migration[6.0]
  def change
    add_column :learning_objects, :admin_notes, :text
  end
end
