class ReportsController < ApplicationController
  def index
    @houses = House.all
  end

  def filters
    filters = params[:filters]
    args = generate_args(filters)
    status = params[:filters][:status]
    @houses = House.all
    @student_checks = student_check_generator(args, filters[:status])

    render 'index'
  end

  private

  def generate_args(filters)
    { start_date: new_start_date(filters),
      end_date: new_end_date(filters),
      houses: find_houses(filters),
      statuses: filters[:student_status] }
  end

  def find_houses(filters)
    House.where(id: filters[:houses])
  end

  def new_start_date(filters)
    Date.new(filters["start_date(1i)"].to_i,
      filters["start_date(2i)"].to_i,
      filters["start_date(3i)"].to_i)
  end

  def new_end_date(filters)
    Date.new(filters["end_date(1i)"].to_i,
      filters["end_date(2i)"].to_i,
      filters["end_date(3i)"].to_i)
  end

  def student_check_generator(args, status)
    return StudentCheck.send(status).filters(args) unless status == "all"
    StudentCheck.filters(args)
  end
end
