class BookingsController < ApplicationController
  def new
    @flight_number ||= params[:flight]
    @flight ||= Flight.find_by_id(params[:flight])

    @booking ||= @flight.bookings.build
    @num_passengers = params[:passenger_count].to_i

    @passengers = []
    @num_passengers.times do |i|
      @passengers << Passenger.new
    end
  end

  def create
    if params.has_key?("passenger")
      Passenger.create(passenger_params(params[:passenger]))
    else
      params["passengers"].each do |passenger|
        if passenger["name"] != "" || passenger["email"] != ""
          Passenger.create(name: params[:passengers][:name], email: params[:passengers][:email])
        end
      end
    end
    @booking = Booking.new
  end

  def show
  end

  private

  def booking_params
    require.permit(:flight, :passenger_count, :passengers => [:name, :email])
  end

end
