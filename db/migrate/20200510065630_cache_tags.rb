class CacheTags < ActiveRecord::Migration[6.0]
  def change
    add_column :global_resources,  :cached_tag_list, :string
    GlobalResource.reset_column_information
    # next line makes ActsAsTaggableOn see the new column and create cache methods
    ActsAsTaggableOn::Taggable::Cache.included(GlobalResource)
    GlobalResource.find_each(batch_size: 1000) do |p|
      p.tag_list
      p.save!
    end
    add_column :global_videos, :cached_tag_list, :string
    GlobalVideo.reset_column_information
    # next line makes ActsAsTaggableOn see the new column and create cache methods
    ActsAsTaggableOn::Taggable::Cache.included(GlobalVideo)
    GlobalVideo.find_each(batch_size: 1000) do |p|
      p.tag_list
      p.save!
    end
  end
end
