class BookingsController < ApplicationController
  before_action :set_event

  def new
    @booking = @event.bookings.build
  end

  def create
    @booking = @event.bookings.build(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to @event, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def booking_params
    params.require(:booking).permit(:message)
  end
end
