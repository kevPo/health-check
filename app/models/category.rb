class Category < ApplicationRecord
  has_many :teamCategories, dependent: :destroy  
  has_many :teams, through: :teamCategories
  default_scope -> { order('name ASC') }
  validates :name, presence: true
end
