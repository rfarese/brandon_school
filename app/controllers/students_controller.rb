class StudentsController < ApplicationController
  before_action :authorize_admin

  def index
    @students = Student.all
    @students = Kaminari.paginate_array(@students).page(params[:page]).per(5)
  end

  def new
    @student = Student.new
    @beds = Student.available_beds
    if @beds.count == 0
      flash[:notice] = "No beds are available"
    end
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      flash[:notice] = "New Student Saved"
      redirect_to students_path
    else
      flash[:notice] = "Please provide valid information."
      @beds = Bed.all
      render "new"
    end
  end

  def show
  end

  def edit
    @student = Student.find(params[:id])
    @beds = Student.available_beds
    @beds << @student.bed
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      flash[:notice] = "Student Updated"
      redirect_to students_path
    else
      flash[:notice] = "Please provide valid information."
      @beds = Student.available_beds
      @beds << @student.bed
      render 'edit'
    end
  end

  def destroy
    student = Student.find(params[:id])
    if student.destroy
      flash[:notice] = "Student Deleted"
    else
      flash[:notice] = "Student Not Deleted"
    end
    redirect_to students_path
  end

  private
  def student_params
    params.require(:student).permit(:initials, :bed_id)
  end
end
