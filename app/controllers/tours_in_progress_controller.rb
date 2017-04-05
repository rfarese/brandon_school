class ToursInProgressController < ApplicationController
  def index
    @houses = House.tours_today

    respond_to do |format|
      format.html
      format.csv { send_data @houses.to_csv }
      format.xls 
    end
  end
end
