class Flight < ApplicationRecord
  belongs_to :origin, class_name: "Airport"
  belongs_to :destination, class_name: "Airport"
  validates :origin_id, presence: true
  validates :destination_id, presence: true
end
