class Api::V1::StudentChecksController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :update

  def generate
    generate_student_checks = GenerateStudentCheck.new(generate_student_check_params[:room_id])
    student_checks = generate_student_checks.generate

    render json: { student_checks: student_checks }
  end

  def update
    student_check = StudentCheck.find(student_check_params[:id])
    if student_check.update(student_check_params)
      notice = "Student Check Complete"
    else
      notice = "There was an error with your Student Check"
    end
    student_check_id = student_check_params[:id]

    render json: { notice: notice, student_check_id: student_check_id }
  end

  private

  def generate_student_check_params
    params.require(:student_check).permit(:room_id)
  end

  def student_check_params
    params.require(:student_check).permit(:id, :status, :comment)
  end
end
