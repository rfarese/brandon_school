class ToursController < ApplicationController
  def new
    @tour = Tour.new
    @houses = current_user.houses
  end

  # See about creating an AJAX request that sends the selfie back to the tours controller
  # Perhaps name the action "begin_create"
  # Create a new tour with the selfie 

  def create
    @tour = Tour.new(tour_params)
    @tour.status = "incomplete"
    @tour.save
    @tour.build_student_checks
    render new_qrcode_scans_path
  end

  private
  def tour_params
    params_hash = params.require(:tour).permit(:selfie, :house_id)
  end
end
