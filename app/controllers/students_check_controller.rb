class StudentChecksController < ApplicationController
  def new
    binding.pry
  end

  private

  def student_check_params
    params.require(:student_check).permit(:room_id)
  end
end
