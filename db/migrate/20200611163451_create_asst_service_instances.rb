class CreateAsstServiceInstances < ActiveRecord::Migration[6.0]
  def change
    create_table :asst_service_instances do |t|
      t.references :learn_mod, null: false, foreign_key: true
      t.string :guid

      t.timestamps
    end
  end
end
