# app/controllers/bookings_controller.rb
class BookingsController < ApplicationController
  # This line ENSURES a user is logged in before the 'create' action can run.
  before_action :authenticate_user!, only: [:create]

  def new
    @event = Event.find(params[:event_id])
    @booking = Booking.new
  end

  def create
    @event = Event.find(params[:event_id])
    @booking = @event.bookings.new(booking_params)
    @booking.user = current_user
    @booking.status = 'pending'
    if @booking.save
      redirect_to @event, notice: 'Booking was successfully created.'
    else
      flash.now[:alert] = @booking.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:event_id, :user_id)
  end
end
