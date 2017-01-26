class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    @rooms = Kaminari.paginate_array(@rooms).page(params[:page]).per(7)
  end

  def new
    @room = Room.new
    @houses = current_user.houses
  end

  def create
    room = Room.new(room_params)
    if room.save
      flash[:notice] = "A room was successfully created."
    else
      flash[:notice] = "Please provide valid information."
    end
    redirect_to root_path
  end

  private

  def room_params
    params.require(:room).permit(:name, :house_id)
  end
end
