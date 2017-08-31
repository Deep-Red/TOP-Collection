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
    @event = Event.find_by_id(params[:id])
    @invitations = @event.invitations.all

  end

  def index
    @events = Event.all
    @past_events = @events.past
    @future_events = @events - @past_events
  end

  private
    def event_params
      params.require(:event).permit(:description, :id)
    end
end
