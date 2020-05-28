# frozen_string_literal: true

# Add role to LearnModOrganizations
class AddRoleToLearnModOrganizations < ActiveRecord::Migration[6.0]
  def change
    add_column :learn_mod_organizations, :world_role_id, :integer
    change_column :characters, :real_world, :boolean, default: false
    remove_column :global_resources, :content_type
  end
end
