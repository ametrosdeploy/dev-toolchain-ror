class CreateDebriefs < ActiveRecord::Migration[6.0]
  def change
    create_table :debriefs do |t|
      t.text :content
      t.references :debriefable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
