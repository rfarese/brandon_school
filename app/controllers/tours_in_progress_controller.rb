class ToursInProgressController < ApplicationController
  def index
    @houses = House.tours_today
  end
end
