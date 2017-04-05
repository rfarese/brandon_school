class ReportsController < ApplicationController
  before_action :authorize_admin

  def index
    @houses = House.all
    deleted_cached_filters if cached_filters?
  end

  def filters
    filters = filter_params
    @houses = House.all
    report_data = ReportGenerator.new(filters)
    @student_checks = report_data.build_student_checks

    unless params[:format] == "xls"
      @student_checks = Kaminari.paginate_array(@student_checks).page(params[:page]).per(10)
    end

    respond_to do |format|
      format.html { render 'index' }
      format.csv
      format.xls
    end
  end

  private

  def filter_params
    if params[:format] == "xls"
      filters = fetch_cached_filters
    else
      filters = params[:filters]
      cache_filters
    end
    filters
  end

  def cached_filters?
    Rails.cache.exist?("filter_parameters")
  end

  def deleted_cached_filters
    Rails.cache.delete("filter_parameters")
  end

  def fetch_cached_filters
    Rails.cache.fetch("filter_parameters")
  end

  def cache_filters
    Rails.cache.fetch("filter_parameters", expires_in: 1.hour) do
      params[:filters]
    end
  end
end
