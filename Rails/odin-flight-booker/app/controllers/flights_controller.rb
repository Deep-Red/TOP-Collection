class FlightsController < ApplicationController

  def index
    @flight ||= Flight.new
    @passengers ||= 0
    @flights ||= Flight.all
    @airports ||= Airport.order(:code).all.map{ |a| [a.code, a.id] }
    @old_dates ||= Flight.order(:start).all.map{ |f| [f.flight_date_formatted, f.start] }
    @dates = @old_dates.map(&:first).uniq
    @matching_flight = Flight.new
    @booking = Booking.new


    if params[:flight_selected].present?

      @flight_number = params[:flight_selected]
      @passengers = params[:passenger_count]
      # "Hacky" fix found on StackOverflow to force html rendering of new_booking_path
      respond_to do |format|
        format.html {redirect_to new_booking_path(flight: @flight_number, passenger_count: @passengers)} if params[:flight].present?
        format.js {render :js => "window.location.href='"+new_booking_path(flight: @flight_number, passenger_count: @passengers)+"'"}
      end


    elsif params[:flight].present? # flight_params[:flight].nil?

      @passengers = flight_params[:passengers]
    #  @search = params[:flight][:origin, :destination, :date]

      selected_date = Date.strptime(params[:flight][:start], "%m/%d/%Y")

      @matching_flights = Flight.where(:origin => params[:flight][:origin], :destination => params[:flight][:destination], :start => selected_date.beginning_of_day..selected_date.end_of_day)

      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def create
  end

  private

  def flight_params
    params.require(:flight).permit(:origin, :destination, :start, :passengers, :flight_selected, :passenger_count)
  end
end
