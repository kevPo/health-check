class Team < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
end
