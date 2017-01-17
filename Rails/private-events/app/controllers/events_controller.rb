class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    @event.save
    redirect_to root_path
  end

  def show
    @event = event.find_by_id(params[:event_id])
  end

  def index
    @events = Event.all
  end

  private
    def event_params
      params.require(:event).permit(:description)
    end
end
