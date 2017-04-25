class StudentChecksController < ApplicationController
  before_action :get_current_tour, only: [:edit, :update]
  before_action :get_current_rooms, only: [:edit, :update]

  def edit
    @room = Room.find_by(qrcode_identifier: finder_params[:qrcode_identifier])
    args = { room_id: @room.id, tour_id: finder_params[:tour_id] }
    @student_checks = StudentCheck.by_room_and_tour(args)
    @rooms.each do |room|
      room.complete_checker(current_tour)
    end
  end

  def update
    student_checks_params = params[:student_checks][:student_checks]

    student_checks_params.each do |student_check_params|
      student_check_id = student_check_params.first
      student_check = StudentCheck.find(student_check_id)
      @current_room ||= student_check.room
      new_params = student_check_params.last
      student_check.assign_attributes(initials: new_params[:initials], status: new_params[:status], comment: new_params[:comment])
      is_student_check_valid?(student_check)
    end
    @student_checks = incomplete_student_checks(@current_room)
    room_complete_checker(@student_checks)
  end

  private
  def finder_params
    { qrcode_identifier: params[:qrcode_identifier], tour_id: params[:tour_id] }
  end

  def student_check_params
    params.require(:student_check).permit(:status, :comment, :initials)
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
      render 'new'
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
end
