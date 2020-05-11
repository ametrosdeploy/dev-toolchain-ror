class SetNullFalseOnGlobalVideos < ActiveRecord::Migration[6.0]
  def change
    change_column :global_videos, :title, :string, null: false
  end
end
