class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def show
    @passenger = Passenger.find_by(id: params[:id])
    @trip = Trip.where(passenger_id: params[:id])

    if @passenger.nil? || @trip.nil?
      head :not_found
    end
  end

  def new
    @passenger = Passenger.new
  end

  def create
    filtered_passenger_params = passenger_params()
    @passenger = Passenger.new(filtered_passenger_params)

    if @passenger.save
      redirect_to passengers_path
    else
      render :new
    end
  end

  def edit
    @passenger = Passenger.find_by(id: params[:id])
  end

  def update
    @passenger = Passenger.find(params[:id])

    if @passenger.update(passenger_params)
      redirect_to passenger_path(@passenger.id)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    passenger = Passenger.find_by(id: params[:id])

    passenger.destroy
    redirect_to passengers_path
  end

  private

  def passenger_params
    return params.require(:passenger).permit(
      :name,
      :phone_num
    )
  end
end
