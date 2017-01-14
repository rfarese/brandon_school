class Api::V1::StudentChecksController < ApplicationController
  def generate
    generate_student_checks = GenerateStudentCheck.new(generate_student_check_params[:room_id])
    student_checks = generate_student_checks.build

    render json: { student_checks: student_checks }
  end

  def update
  end

  private

  def generate_student_check_params
    params.require(:student_check).permit(:room_id)
  end
end
