class Api::V1::StudentChecksController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :update
  # after_action :tour_complete?, only: [:update]
  # after update, check to see if tour is complete
  # if it is complete,

  def generate
    @current_tour = Tour.find(params[:tour_id])
    generate_student_checks = GenerateStudentCheck.new(generate_student_check_params)
    @student_checks = generate_student_checks.generate

    render json: { student_checks: student_checks, current_tour: current_tour }
  end

  def update
    student_check = StudentCheck.find(student_check_params[:id])

    if student_check.update(student_check_params)
      notice = "Student Check Complete"
    else
      notice = "There was an error with your Student Check"
    end

    student_check_id = student_check_params[:id]
    render json: { notice: notice, student_check_id: student_check_id, tour_complete: tour_complete? }
  end

  private

  def generate_student_check_params
    { room_id: params[:room_id], tour_id: params[:tour_id] }
  end

  def student_check_params
    params.require(:student_check).permit(:id, :status, :comment)
  end

  def tour
    student_check = StudentCheck.find(student_check_params[:id])
    student_check.checkable
  end

  def tour_complete?
    tour.complete?
  end
end
