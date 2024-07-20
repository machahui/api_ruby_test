class Favorite < ApplicationRecord
  validates :title, presence: true
  validates :date, presence: true
  belongs_to :user
end
