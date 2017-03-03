class ReportsController < ApplicationController
  before_action :authorize_admin

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
