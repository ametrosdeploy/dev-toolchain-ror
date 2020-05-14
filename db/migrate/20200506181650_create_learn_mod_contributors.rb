class CreateLearnModContributors < ActiveRecord::Migration[6.0]
  def change
    create_table :learn_mod_contributors do |t|
      t.references :learn_mod_contributor_role, null: false, foreign_key: true
      t.references :learn_mod, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
