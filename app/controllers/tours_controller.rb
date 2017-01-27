class ToursController < ApplicationController
  def new
    @tour = Tour.new
    @houses = current_user.houses
  end

  def create
    @tour = Tour.new(tour_params)
    @tour.status = "incomplete"
    @tour.save
    render new_qrcode_scans_path
  end

  private
  def tour_params
    params_hash = params.require(:tour).permit(:selfie, :house_id)
  end
end
