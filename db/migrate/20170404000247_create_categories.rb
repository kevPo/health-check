class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :team_id
      t.string :awesome
      t.string :crappy

      t.timestamps
    end
    add_index :categories, [:team_id, :created_at]
  end
end
