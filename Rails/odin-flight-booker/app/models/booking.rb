class Booking < ApplicationRecord
  has_and_belongs_to_many :passengers
  belongs_to :flight
  accepts_nested_attributes_for :passengers
end
