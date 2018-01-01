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
      cache_tour_id
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

  def cache_tour_id
    if Rails.cache.exist?("user_#{current_user.id}_current_tour_id")
      Rails.cache.delete("user_#{current_user.id}_current_tour_id")
    end
    Rails.cache.fetch("user_#{current_user.id}_current_tour_id", expires_in: 1.hour) do
      @tour.id
    end
  end
end
