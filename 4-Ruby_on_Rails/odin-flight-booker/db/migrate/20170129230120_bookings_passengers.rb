class BookingsPassengers < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings_passengers, :id => false do |t|
      t.integer :booking_id
      t.integer :passenger_id
    end
  end

end
