class AddNameToEmailSkills < ActiveRecord::Migration[6.0]
  def change
    add_column :email_skills, :name, :string
  end
end
