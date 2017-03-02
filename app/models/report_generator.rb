class ReportGenerator
  attr_reader :filters, :status, :args

  def initialize(filters)
    @filters = filters
    @status = filters[:status]
    @args = generate_args(filters)
  end

  # you should just be able to remove @args = generate_args(filters) from initialize
  # then, in generate_args method, just add @args = { start_date: ... }
  # then you can remove all the (filters) arguments and parameters to
  # generate_args, find_houses, new_start_date, and new_end_date
  # however, you will have to look in your controllers and see where you'll have
  # to call generate_args because you are calling it automatically when the object
  # is instanciated 

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

  def build_student_checks
    if status == "all"
      StudentCheck.filters(args)
    else
      StudentCheck.send(status).filters(args) unless status == "all"
    end
  end
end
