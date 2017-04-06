class Team < ApplicationRecord
  has_many :teamCategories, dependent: :destroy  
  has_many :categories, through: :teamCategories
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
end
