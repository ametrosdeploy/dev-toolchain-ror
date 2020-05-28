# frozen_string_literal: true

class AddMissingIndexOnWorldOrg < ActiveRecord::Migration[6.0]
  def change
    add_reference :worlds, :customer, foreign_key: true, index: true, null: false
    add_reference :organizations, :industry, foreign_key: true, index: true, null: false
  end
end
