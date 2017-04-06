class RemoveTeamIdFromCategories < ActiveRecord::Migration[5.0]
  def change
    remove_column :categories, :team_id, :integer
  end
end
