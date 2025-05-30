# app/controllers/bookings_controller.rb
class BookingsController < ApplicationController
  # This line ENSURES a user is logged in before the 'create' action can run.
  before_action :authenticate_user!, only: [:new, :create, :update]
  # Ensure owners can accept or decline
  before_action :set_booking, only: [:update]
  before_action :authorize_owner!, only: [:update]

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

      Notification.create!(
        user: @booking.event.venue.user,   # the venue owner
        action: "booking_requested",
        notifiable: @booking
      )
    else
      flash.now[:alert] = @booking.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @booking.update(status: params[:booking][:status])
            Notification.create!(
        user:      @booking.user,            # the musician
        action:    "booking_#{@booking.status}",
        notifiable: @booking
      )
      redirect_to bookings_path, notice: "Booking #{@booking.status.humanize.downcase}."
    else
      flash.now[:alert] = @booking.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def authorize_owner!
    # Ensure current_user owns the event's venue
    unless @booking.event.venue.user == current_user
      redirect_to root_path, alert: "Not authorized."
    end
  end

  def booking_params
    params.require(:booking).permit(:event_id, :status).merge(user: current_user)
  end
end
