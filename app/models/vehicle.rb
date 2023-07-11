class Vehicle < ApplicationRecord
  has_many :appearances
  has_many :films, through: :appearances
end
