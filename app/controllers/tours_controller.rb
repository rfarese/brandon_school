require 'base64'
class ToursController < ApplicationController
  def new
    @tour = Tour.new
    @houses = current_user.houses
  end

  def selfie_upload
    @tour = Tour.new(selfie: params[:image].tempfile)
    @tour.save
    @houses = current_user.houses
    render json: { tour_id: @tour.id }
  end

  def create
    @tour = Tour.find(params[:tour][:id])
    @tour.house_id = params[:tour][:house_id]
    @tour.status = "incomplete"
    @tour.save
    @tour.build_student_checks
    render new_qrcode_scans_path
  end

  private
  def tour_params
    params_hash = params.require(:tour).permit(:house_id, :id)
  end
end
