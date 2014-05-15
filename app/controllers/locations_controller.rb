class LocationsController < ApplicationController
before_action :set_account

  def index
  end

  def new
  end

  def show
  end

  def edit
  end

  def update
    if @account.locations.find(params[:id]).update(location_params)
      redirect_to account_locations_path(@account), notice: "location updated successfully."
    else
      render 'edit'
    end
  end

  def create
    if @account.locations.create(location_params)
      redirect_to account_locations_path(@account), notice: "location created successfully."
    else
      render 'new'
    end
  end

  def destroy
    @account.locations.find(params[:id]).destroy

    redirect_to account_locations_path(@account), notice: "location deleted."
  end

  def location_params
    params.require(:location).permit(:name)
  end

  def set_account
    @account = Account.find_by(id: params[:account_id])
  end
end
