require 'base64'
class ToursController < ApplicationController
  def new
    @tour = Tour.new
    @houses = current_user.houses
  end

  # See about creating an AJAX request that sends the selfie back to the tours controller
  # Perhaps name the action "selfie_upload"
  # Create a new tour with the selfie

  def selfie_upload
    # this temporarily saves the selfie
    # File.open("#{Rails.root}/public/uploads/somefilename.jpg", 'wb') do |f|
    #   f.write(params[:image].read)
    # end

    @tour = Tour.new(selfie: params[:image].tempfile)
    @tour.save
    # if you save the selfie before adding it to the tour...
    # @tour.selfie = Rails.root.join("public/uploads/somefilename.jpg").open

    @houses = current_user.houses

    render 'new'
  end

  def create
    binding.pry
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
