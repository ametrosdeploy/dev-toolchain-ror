class MoveGenderToSeperateTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :characters, :gender, :gender_id
  end
end
