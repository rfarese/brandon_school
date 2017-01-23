class StudentChecksController < ApplicationController
  # after_action :room_complete?, only: update
  # after_action :tour_complete?, if: room_complete?, only: :update

  def new
    @tour = Tour.find(params[:tour_id])
    generate_student_checks = GenerateStudentCheck.new(generate_student_check_params)
    @student_checks = generate_student_checks.generate
  end

  def update
    student_check = StudentCheck.find(params[:id])
    student_check.update(status: student_check_params[:status],
      comment: student_check_params[:comment],
      complete: true)
    @tour = tour
    @student_checks = incomplete_student_checks(student_check)

    if @student_checks.count == 0
      if tour_complete?
        flash[:notice] = "Tour is complete"
        @tour.status = "complete"
        @tour.save
        redirect_to root_path
      else
        flash[:notice] = "Scan Next QR Code"
        render 'qrcode_scans/new'
      end
    else
      render 'new'
    end
  end

  private
  def generate_student_check_params
    { room_id: params[:room_id], tour_id: params[:tour_id] }
  end

  def student_check_params
    params.require(:student_check).permit(:status, :comment)
  end

  def get_tour_id
    params[:student_check][:tour_id]
  end

  def tour
    Tour.find(get_tour_id)
  end

  def tour_complete?
    tour.complete?
  end

  def incomplete_student_checks(student_check)
    # need to get tour from student_check like this: student_check.tour
    tour = student_check.tour 
    tour.student_checks.where(complete: false)
  end
end
