class StudentChecksController < ApplicationController
  before_action :get_current_tour, only: [:new, :update]

  def new
    @student_checks = StudentCheckFinder.new(finder_params).by_room_and_tour
  end

  def update
    student_check = StudentCheck.find(params[:id])
    current_room = student_check.room
    student_check.assign_attributes(student_check_params)
    if student_check.valid?
      student_check.complete_status = 1
      student_check.save
    end
    @student_checks = incomplete_student_checks_by_room(current_room)
    complete_checker(@student_checks)
  end

  private
  def finder_params
    { room_id: params[:room_id], tour_id: params[:tour_id] }
  end

  def student_check_params
    params.require(:student_check).permit(:status, :comment)
  end

  def get_current_tour
    @tour = current_tour
  end

  def tour_complete_check
    if @tour.complete?
      tour_completer
      redirect_to root_path
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
    render 'qrcode_scans/new'
  end

  def complete_checker(student_checks)
    if student_checks.count == 0
      tour_complete_check
    else
      render 'new'
    end
  end

  def incomplete_student_checks_by_room(room)
    args = { tour_id: current_tour.id, room_id: room.id }
    StudentCheckFinder.new(args).incomplete_by_room_and_tour
  end
end
