class ReportsController < ApplicationController
  def index
    @houses = House.all
  end

  def filters
    filters = params[:filters]
    @houses = House.all
    report_data = ReportGenerator.new(filters)
    @student_checks = report_data.build_student_checks

    render 'index'
  end
end
