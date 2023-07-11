class Film < ApplicationRecord
  has_many :appearances
  has_many :vehicles, through: :appearances
end
