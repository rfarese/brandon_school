class ToursController < ApplicationController
  def new
    @tour = Tour.new
    @houses = current_user.houses
  end

  def create
    @tour = Tour.new(tour_params)
    @tour.status = "incomplete"
    @tour.save
    # generate the student checks for the entire tour
    @tour.build_student_checks_by_beds
    binding.pry
    # @tour.build_student_checks
    render new_qrcode_scans_path
  end

  private
  def tour_params
    params_hash = params.require(:tour).permit(:selfie, :house_id)
  end
end
