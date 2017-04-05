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
    start_date = Date.new(filters["start_date(1i)"].to_i,
                          filters["start_date(2i)"].to_i,
                          filters["start_date(3i)"].to_i)

    (start_date.to_time + 5.hours).to_datetime
  end

  def new_end_date(filters)
    end_date = Date.new(filters["end_date(1i)"].to_i,
                        filters["end_date(2i)"].to_i,
                        filters["end_date(3i)"].to_i)

    (end_date.to_time + 5.hours).to_datetime
  end

  def build_student_checks
    if status == "all"
      StudentCheck.includes(tour: :house).filters(args)
    else
      StudentCheck.includes(tour: :house).send(status).filters(args)
    end
  end
end
