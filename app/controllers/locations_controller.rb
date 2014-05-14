class LocationsController < ApplicationController
before_action :set_location, only: [:show, :update, :edit]

  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def show
  end

  def edit
  end

  def update
    if @location.update(location_params)
      redirect_to locations_url, notice: "Location updated successfully."
    else
      render 'edit'
    end
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to locations_url, notice: "Location created successfully."
    else
      render 'new'
    end
  end

  def destroy
    @location = Location.find_by(id: params[:id])
    @location.destroy

    redirect_to locations_url, notice: "Location deleted."
  end

  def location_params
    params.require(:location).permit(:name)
  end

  def set_location
    @location = Location.find_by(id: params[:id])
  end
end
