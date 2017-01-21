class FlightsController < ApplicationController

  def index
    @booking ||= "Dummy value"
    @flights ||= Flight.all
    @airports ||= Airport.order(:code).all.map{ |a| [a.code, a.id] }
    @dates ||= Flight.order(:start).all.map{ |f| [f.flight_date_formatted, f.id] }
  end

end
