class StudentChecksController < ApplicationController
  before_action :get_current_tour, only: [:edit, :update]
  before_action :get_current_rooms, only: [:edit, :update]
  before_action :get_current_tour_id, only: :update

  def edit
    tour_cache_manager = TourCacheManager.new(current_tour, params[:qrcode_identifier].to_i)
    tour_cache_manager.execute
    tour_manager = tour_cache_manager.tour_manager
    @rooms = tour_manager.rooms
    @room = tour_manager.current_room
    @student_checks = tour_manager.current_student_checks
  end

  def update
    # check and see if you get a tour_id or tour param
    updater = StudentCheckUpdater.new(student_checks_params, @tour_id)
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

  def get_current_tour_id
    @tour_id = Rails.cache.fetch("user_#{current_user.id}_current_tour_id")
  end

  def get_current_tour
    @tour = current_tour
  end

  def get_current_rooms
    @rooms = current_tour.rooms
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
    flash[:notice] = "Scan Next QR Code"
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

  # tour_manager_cache
  def delete_tour_manager_cache
    Rails.cache.delete("tour_manager_cache")
  end
end
