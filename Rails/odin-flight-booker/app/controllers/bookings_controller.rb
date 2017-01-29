class BookingsController < ApplicationController
  def new
    @flight_number ||= params[:flight]
    @flight ||= Flight.find_by_id(params[:flight])

    @booking ||= @flight.bookings.build
    @num_passengers = params[:passenger_count].to_i

    @group = []
    @num_passengers.times do |i|
      @group << Passenger.new
    end
  end

  def create
    @flight = Flight.find_by_id(params[:flight])
    @num_passengers = params[:booking][:passenger_count].to_i
    @count = 0
    @booking = @flight.bookings.build
    @num_passengers.times do
        @count += 1
        passenger = @booking.passengers.build
        passenger.name = params[:passengers]["#{@count}"][:name]
        passenger.email = params[:passengers]["#{@count}"][:email]
        passenger.save
    end
    @booking.save
    redirect_to @booking
  end

  def show
    @booking = Booking.find_by_id(params[:id])
    @passengers = @booking.passengers.all
  end

  private

  def booking_params
    require.permit(:flight, :passenger_count, :passengers => [:name, :email])
  end

end
