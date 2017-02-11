class StudentChecksController < ApplicationController
  before_action :get_current_tour, only: [:new, :update]

  def new
    # change the GenerateStudentCheck to StudentCheckFinder
    # use the tour_id and the room_id to find all the student checks 
    generate_student_checks = GenerateStudentCheck.new(generate_student_check_params)
    @student_checks = generate_student_checks.generate
  end

  def update
    student_check = StudentCheck.find(params[:id])
    student_check.assign_attributes(student_check_params)
    if student_check.valid?
      student_check.complete_status = 1
      student_check.save
    end
    @student_checks = @tour.incomplete_student_checks
    complete_checker
  end

  private
  def generate_student_check_params
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

  def complete_checker
    if @tour.current_room_complete?
      tour_complete_check
    else
      render 'new'
    end
  end
end
