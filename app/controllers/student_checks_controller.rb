class StudentChecksController < ApplicationController
  before_action :get_tour_and_rooms, only: [:edit, :update]
  before_action :authorize_user

  def edit
    valid_identifiers = get_valid_qrcode_identifiers
    current_identifier = params[:qrcode_identifier].to_i

    if valid_identifiers.include?(current_identifier)
      tour_manager = TourManager.new(@tour, current_identifier)
      tour_manager.organize
      @rooms = tour_manager.rooms
      @room = tour_manager.current_room
      @student_checks = tour_manager.current_student_checks
    else
      flash.now[:notice] = "The QR Code didn't scan properly. Please try again."
      render qrcodes_scan_path
    end
  end

  def update
    updater = StudentCheckUpdater.new(student_checks_params, @tour)
    updater.execute
    @room = updater.current_room
    @rooms = updater.rooms
    @student_checks = incomplete_student_checks(@room)
    room_complete_checker(@student_checks)
  end

  private

  def student_checks_params
    params[:student_checks][:student_checks].values
  end

  def get_tour_and_rooms
    @tour = current_tour
    @rooms = @tour.rooms
  end

  def tour_complete_check
    if @tour.complete?
      tour_completer
      delete_tour_manager_cache
      render "homes/index"
    else
      scan_next_qrcode
    end
  end

  def tour_completer
    flash[:notice] = "Tour is complete"
    @tour.status = "complete"
    @tour.save
  end

  def scan_next_qrcode
    flash.now[:notice] = "Scan Next QR Code"
    render qrcodes_scan_path
  end

  def room_complete_checker(student_checks)
    if student_checks.count == 0
      tour_complete_check
    else
      render 'edit'
    end
  end

  def incomplete_student_checks(room)
    args = { tour_id: current_tour.id, room_id: room.id }
    StudentCheck.by_room_and_tour(args).incomplete
  end

  def is_student_check_valid?(student_check)
    if student_check.valid?
      student_check.complete_status = 1
      student_check.save
    end
  end

  def delete_tour_manager_cache
    Rails.cache.delete("tour_#{@tour_id}_manager_cache")
  end

  def get_valid_qrcode_identifiers
    valid_identifiers = []
    @rooms.each do |room|
      valid_identifiers << room.qrcode_identifier
    end
    valid_identifiers
  end

  def get_qrcode_identifier
    params[:student_checks][:student_checks].values.first[:qrcode_identifier]
  end
end
