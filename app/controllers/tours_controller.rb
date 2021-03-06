class ToursController < ApplicationController
  before_action :authorize_user

  def new
    @tour = Tour.new
    @selfie = Selfie.find(params[:selfie_id])
    @houses = current_user.houses
  end

  def create
    @selfie = Selfie.find(params[:selfie_id])
    @tour = Tour.new(tour_params)
    @tour.selfie = @selfie

    if @tour.save
      @tour = Tour.includes(house: [:rooms, :beds]).find(@tour.id)
      @tour.build_student_checks
      flash.now[:notice] = "Tour successfully started."
      render qrcodes_scan_path
    else
      flash[:notice] = "Tour failed to start."
      render 'new'
    end
  end

  private
  def tour_params
    params.require(:tour).permit(:house_id, :status)
  end
end
