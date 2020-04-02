class CreateVideoLearnObjs < ActiveRecord::Migration[6.0]
  def change
    create_table :video_learn_objs do |t|

      t.timestamps
    end
  end
end
