class ReportGenerator
  attr_reader :filters, :status, :args

  def initialize(filters)
    @filters = filters
    @status = filters[:status]
    @args = generate_args(filters)
  end

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
