# frozen_string_literal: true

# Adding missing migration on FileLearnObj
class AddColumnGlobalResourceIdToFileLearnObj < ActiveRecord::Migration[6.0]
  def change
    add_reference :file_learn_objs, :global_resource, foreign_key: true,
                                                      index: true, null: false
  end
end
