class CreateLearnModContributorRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :learn_mod_contributor_roles do |t|
      t.string :title

      t.timestamps
    end
  end
end
