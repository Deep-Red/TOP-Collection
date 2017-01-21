class FlightsController < ApplicationController

  def index
    @flight ||= Flight.new
    @passengers ||= 0
    @flights ||= Flight.all
    @airports ||= Airport.order(:code).all.map{ |a| [a.code, a.id] }
    @dates ||= Flight.order(:start).all.map{ |f| [f.flight_date_formatted, f.start] }

    if params[:flight].present? # flight_params[:flight].nil?

      @passengers = flight_params[:passengers]
    #  @search = params[:flight][:origin, :destination, :date]

      selected_date = Date.parse(params[:flight][:start])

      @matching_flights = Flight.where(:origin => params[:flight][:origin], :destination => params[:flight][:destination], :start => selected_date.beginning_of_day..selected_date.end_of_day)

      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def create
  end

  def flight_params
    params.require(:flight).permit(:origin, :destination, :start, :passengers)
  end
end
