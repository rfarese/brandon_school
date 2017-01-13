class Api::V1::StudentChecksController < ApplicationController
  # NOTE - need to remove the polymorphic relationship for students checks
  # and add student has_many student checks and student check belongs_to student

  def generate_student_checks
    room = Room.find(generate_student_checks_params[:room_id])
    students = room.students
    @student_checks = []

    students.each do |student|
      @student_checks << StudentCheck.new(checkable: student)
    end

    render 'student_checks/new'
    # redirect_to new_student_check_path(student_checks: @student_checks.to_json)
  end

  def create
  end

  private
  def generate_student_checks_params
    params.require(:student_check).permit(:room_id)
  end

  def student_check_params
    params.require(:student_check).permit()
  end
end
