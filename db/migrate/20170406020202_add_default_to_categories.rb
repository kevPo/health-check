class AddDefaultToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :default, :boolean, default: false
  end
end
