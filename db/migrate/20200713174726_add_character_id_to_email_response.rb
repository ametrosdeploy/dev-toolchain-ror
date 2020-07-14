class AddCharacterIdToEmailResponse < ActiveRecord::Migration[6.0]
  def change
    add_column :email_responses, :character_id, :integer
  end
end
