class BookingsController < ApplicationController
  def new
    @flight_number ||= params[:flight]
    @flight ||= Flight.find_by_id(params[:flight])
    @passengers = params[:passenger_count]

    @booking ||= @flight.bookings.build
    @num_passengers = params[:passengers].to_i

  end

  def create
    @booking = Booking.new
  end

  def show
  end

  private

  def booking_params
    require.permit(:flight, :passenger_count)
  end
end
