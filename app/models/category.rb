class Category < ApplicationRecord
  belongs_to :team
  default_scope -> { order('name ASC') }
  validates :name, presence: true
  validates :team_id, presence: true
end
