class ReservationsController < ApplicationController
  def index
    render json: Reservation.hash_with_user_name
  end

  def create
    reservation = Reservation.new(scheduled_at: params[:scheduled_at],
                                    user: current_user,
                                    canceled: false)
    if reservation.save
      render json: {id: reservation.id, name: current_user.first_name}, status: 200
    else
      render json: {error_messages: reservation.errors.messages}, status: 403
    end
  end

  def cancel
    reservation = Reservation.find(params[:id])
    if reservation.cancel
      render json: {id: reservation.id}, status: 200
    else
      render json: {error_messages: reservation.errors.messages}, status: 403
    end
  end
end
