class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
  end

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end
  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end
  private
  def event_params
    params.require(:event).permit(:title, :description, :date, :time, :max_slots).merge(user: current_user)
  end
end
