class Passenger < ApplicationRecord
  has_many :bookings
  has_many :flights, through: :bookings
  accepts_nested_attributes_for :bookings
end
