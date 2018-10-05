class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
    end
  end

  def create
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      driver = Driver.all.sample
      @trip = passenger.trips.new(driver_id: driver.id, passenger_id: passenger.id, date: "2017-02-02", rating: 0, cost: 0)

      if @trip.save
        redirect_to passenger_path(passenger.id)
      else
        render :new
      end
      # Same thing as above:
      # @book = Book.new(author: author)
    else
      render :new
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])
  end

  def update
    trip = Trip.find(params[:id])
    trip.update(trip_params)

    redirect_to trip_path(trip.id)
  end

  def destroy
    trip = Trip.find_by(id: params[:id])

    trip.destroy
    redirect_to trips_path
  end

  private

  def trip_params
    return params.require(:trip).permit(
      :date,
      :rating,
      :cost
    )
  end
end
