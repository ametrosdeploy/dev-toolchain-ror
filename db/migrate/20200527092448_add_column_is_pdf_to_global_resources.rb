# frozen_string_literal: true

# Migration to add is_pdf column to global_resources
class AddColumnIsPdfToGlobalResources < ActiveRecord::Migration[6.0]
  def change
    add_column :global_resources, :is_pdf, :boolean, default: false
  end
end
