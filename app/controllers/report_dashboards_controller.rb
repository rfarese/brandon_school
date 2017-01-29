class ReportDashboardsController < ApplicationController
  def index
    @houses = House.all
  end

  def check_ins
    houses = House.where(id: houses_params)
    @check_in_ids = StudentCheck.ids_by_house(houses)
    render 'index'
  end

  def status
    check_in_ids = check_ins_params.split(" ").map { |i| i.to_i }
    all_student_checks = StudentCheck.where(id: check_in_ids)
    # how do we return all student checks when user chooses "all"
    # how do we return complete student checks when user chooses "complete"
    # how do we return incomplete student checks when user chooses "incomplete"
    binding.pry
    render 'index'
  end

  private
  def houses_params
    params[:choosen_houses][:id]
  end

  def check_ins_params
    params[:choosen_check_ins][:check_in_ids]
  end

  def check_in_status_params
    params[:choosen_check_ins][:status]
  end
end
