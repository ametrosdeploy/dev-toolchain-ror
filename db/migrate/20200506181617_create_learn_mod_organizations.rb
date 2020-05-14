class CreateLearnModOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :learn_mod_organizations do |t|
      t.boolean :is_learner_organization
      t.text :abstract
      t.references :learn_mod, null: false, foreign_key: true
      t.references :world_organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
