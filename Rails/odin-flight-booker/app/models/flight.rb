class Flight < ApplicationRecord
  belongs_to :origin, class_name: "Airport"
  belongs_to :destination, class_name: "Airport"
  has_many :bookings
  has_many :passengers, through: :bookings
  validates :origin_id, presence: true
  validates :destination_id, presence: true
  accepts_nested_attributes_for :bookings

  def flight_date_formatted
    start.strftime("%m/%d/%Y")
  end

end
