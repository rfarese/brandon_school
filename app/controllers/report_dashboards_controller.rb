class ReportDashboardsController < ApplicationController

  ###################################################################################
  #######  Most of this extra code should be moved into a report dashboard model ####
  ###################################################################################

  def index
    @houses = House.all
  end

  def check_ins
    houses = House.where(id: houses_params)
    # refactor ids_by_house by using pluck and a better query
    @check_in_ids = StudentCheck.ids_by_house(houses)
    render 'index'
  end

  def status
    check_in_ids = check_in_ids_params.split(" ").map { |i| i.to_i }
    checks = StudentCheck.where(id: check_in_ids)
    @filtered_student_check_ids = filter_student_checks(status_params, checks)

    render 'index'
  end

  def students
    check_in_ids = student_check_in_ids_params.split(" ").map { |i| i.to_i }
    checks = StudentCheck.where(id: check_in_ids)
    @filtered_check_ids = find_ids(student_status_params, checks)
    @student_initials = student_initials_by_checks(checks)

    render 'index'
  end

  def date
    check_in_ids = student_intials_id_params.split(" ").map { |i| i.to_i }
    checks = StudentCheck.where(id: check_in_ids)
    initials = student_initials_params
    student_checks = find_checks_by_initials(checks, initials)
    # filter all the student_checks by student initals
      # iterate over all the student initials
      # pass each initial into a filter method that iterates over the student checks to find the ones that are associated with that students initials
    binding.pry
    render 'index'
  end

  private
  # start params
  def houses_params
    params[:choosen_houses][:id]
  end

  def check_in_ids_params
    params[:choosen_check_ins][:check_in_ids]
  end

  def status_params
    params[:choosen_check_ins][:status]
  end

  def student_status_params
    params[:student_status_selections][:student_status]
  end

  def student_check_in_ids_params
    params[:student_status_selections][:filtered_student_check_ids]
  end

  def student_initials_params
    params[:student_initials_selections][:initials]
  end

  def student_intials_id_params
    params[:student_initials_selections][:filtered_check_ids]
  end
  # end params

  def filter_student_checks(status, student_checks)
    ids = []
    if status == "all"
      ids << student_checks_all_ids(student_checks)
    elsif status == "complete"
      ids << student_checks_complete_ids(student_checks)
    else
      ids << student_checks_incomplete_ids(student_checks)
    end
    ids.flatten
  end

  def student_checks_complete_ids(student_checks)
    ids = []
    student_checks.each do |student_check|
      ids << student_check.id if student_check.complete?
    end
    ids
  end

  def student_checks_incomplete_ids(student_checks)
    ids = []
    student_checks.each do |student_check|
      ids << student_check.id if student_check.incomplete?
    end
    ids
  end

  def student_checks_all_ids(student_checks)
    ids = []
    student_checks.each do |student_check|
      ids << student_check.id
    end
    ids
  end

  def student_initials_by_checks(student_checks)
    initials = []
    student_checks.each do |student_check|
      initials << student_check.student.initials
    end
    initials.uniq
  end

  def find_checks_by_initials(student_checks, initials)
    checks = []
    initials.each do |initial|
      checks << find_check_by_inital(student_checks, initial)
    end
    checks
  end

  def find_check_by_inital(student_checks, initial)
    student_checks.each do |student_check|
      return student_check if student_check.student.initials == initial
    end
  end
end
