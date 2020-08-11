class AddFinalDebriefOverviewToLearnMods < ActiveRecord::Migration[6.0]
  def change
    add_column :learn_mods, :final_debrief_overview, :text
  end
end
