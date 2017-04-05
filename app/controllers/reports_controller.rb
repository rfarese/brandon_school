class ReportsController < ApplicationController
  before_action :authorize_admin

  def index
    @houses = House.all
  end

  # see how you can cache the houses
  # either in Rails or in the browser so that we don't have to make another
  # database call to collect all the houses again in the filters action
  def filters
    filters = params[:filters]
    @houses = House.all
    report_data = ReportGenerator.new(filters)
    @student_checks = report_data.build_student_checks
    @student_checks = Kaminari.paginate_array(@student_checks).page(params[:page]).per(10)

    render 'index'
  end
end
