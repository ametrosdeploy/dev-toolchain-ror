class ChangeGuidOnAsstAssistantShells < ActiveRecord::Migration[6.0]
  def change
    rename_column :asst_assistant_shells, :guid, :assistant_id
  end
end
