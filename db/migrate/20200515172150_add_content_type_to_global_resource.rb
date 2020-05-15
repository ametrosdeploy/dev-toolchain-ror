class AddContentTypeToGlobalResource < ActiveRecord::Migration[6.0]
  def change
    add_column :global_resources, :content_type, :integer
  end
end
