class CreateTeamCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :team_categories do |t|
      t.integer :team_id
      t.integer :category_id

      t.timestamps
    end
  end
end
