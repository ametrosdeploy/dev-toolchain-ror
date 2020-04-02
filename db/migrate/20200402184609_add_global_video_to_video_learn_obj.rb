class AddGlobalVideoToVideoLearnObj < ActiveRecord::Migration[6.0]
  def change
    add_reference :video_learn_objs, :global_video, null: false, foreign_key: true
  end
end
