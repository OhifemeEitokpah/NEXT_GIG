# app/controllers/bookings_controller.rb
class BookingsController < ApplicationController
  # This line ENSURES a user is logged in before the 'create' action can run.
  before_action :authenticate_user!, only: [:create]

  def create
    @event = Event.find(params[:event_id])
    @booking = @event.bookings.new(booking_params)

    # Since authenticate_user! runs first, current_user will always be present here.
    @booking.user = current_user

    @booking.status = :pending # Explicitly set status to pending
    @booking.booking_date = Time.current # Set the booking date to now

    if @booking.save
      # No longer storing in session as guest bookings are not allowed.
      flash[:notice] = 'Booking confirmed! Your spot is reserved.'
      redirect_to event_path(@event)
    else
      # If save fails due to validations, show errors on the same page.
      flash.now[:alert] = "Booking failed: #{@booking.errors.full_messages.to_sentence}"
      # Ensure @event is set for the render in case of validation errors
      @event = Event.find(params[:event_id]) # Re-fetch @event if needed, though it should be already
      render 'events/show', status: :unprocessable_entity
    end
  end

  def update
    @booking = Booking.find(params[:id])
    @event = @booking.event
    @booking.status = params[:status] if params[:status].present?
    if @booking.save
      redirect_to dashboard_path, notice: 'Booking status was successfully updated.'
    else
      flash.now[:alert] = @booking.errors.full_messages.to_sentence
      render :dashboard
    end
  end

  private

  def booking_params
    # Permit only number_of_tickets, as user_id and status are set by the controller.
    params.require(:booking).permit(:number_of_tickets)
  end
end
