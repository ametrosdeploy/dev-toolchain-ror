class CreateWorldRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :world_roles do |t|
      t.string :name

      t.timestamps
    end
  end
end
