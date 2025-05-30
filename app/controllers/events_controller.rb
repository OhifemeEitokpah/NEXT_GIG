class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @available_slots = @event.max_slots - @event.bookings.where.not(status: 'declined').count
    # Define if the user has already booked this event
    @has_booked = @event.bookings.exists?(user: current_user) if user_signed_in?
    # return booked status
    @booking_status = @event.bookings.find_by(user: current_user).status if user_signed_in? && @has_booked
    # Define if the event is in the past
    # @is_past = @event.date < Date.current || (@event.date == Date.current && @event.time < Time.current)
  end


  def index
    @events = Event.all
    @last_three = Event.last(3)
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

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  private
  def event_params
    params.require(:event).permit(:title, :description, :date, :time, :max_slots, :photo).merge(user: current_user)
  end
end
