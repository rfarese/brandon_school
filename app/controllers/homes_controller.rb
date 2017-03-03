class HomesController < ApplicationController
  def index
    if user_signed_in? && current_user.role == "overnight_staff"
      house = current_user.houses.first
      @tour = house.tours.last
    end
  end
end
