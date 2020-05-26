# frozen_string_literal: true

# Creating table for slider images
class CreateSliderImages < ActiveRecord::Migration[6.0]
  def change
    create_table :slider_images do |t|
      t.string :caption
      t.references :slide_learn_obj, null: false, foreign_key: true
      t.references :global_resource, null: false, foreign_key: true

      t.timestamps
    end
  end
end
