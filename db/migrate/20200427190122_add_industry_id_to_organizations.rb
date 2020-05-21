# frozen_string_literal: true

class AddIndustryIdToOrganizations < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :characters_count, :integer, default: 0
  end
end
