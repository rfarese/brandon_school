require 'base64'
class ToursController < ApplicationController
  def new
    @tour = Tour.new
    @houses = current_user.houses
  end

  def selfie_upload
    @tour = Tour.new(set_selfie_attributes)
    @tour.save
    @houses = current_user.houses
    render json: { tour_id: @tour.id, house_status: @tour.house }
  end

  def create
    @tour = Tour.includes(house: [:rooms, :beds]).find(params[:tour][:id])
    # @tour = Tour.find(params[:tour][:id])
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

  def set_selfie_attributes
    selfie = params[:image].tempfile
    house_id = current_user.houses.pluck(:id).first
    { house_id: house_id, selfie: selfie }
  end
end
