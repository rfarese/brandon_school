class RoomsController < ApplicationController
  before_action :authorize_admin
  # before_action :build_qrcode, only: [:create]

  def index
    @rooms = Room.all
    @rooms = Kaminari.paginate_array(@rooms).page(params[:page]).per(7)
  end

  def new
    @room = Room.new
    @houses = House.all
  end

  # before create, build the unique qrcode identifier
  # it'll get saved to the database when the room is saved
  #

  def create
    @room = Room.new(room_params)
    @room.qrcode_identifier = @room.generate_qrcode_identifier

    if @room.save
      flash[:notice] = "A room was successfully created."
      redirect_to rooms_path
    else
      flash[:notice] = "Please provide valid information."
      @houses = House.all
      render 'new'
    end
  end

  def show
  end

  def edit
    @room = Room.find(params[:id])
    @houses = House.all
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "Room Edited"
      redirect_to rooms_path
    else
      flash[:notice] = "Please provide valid information."
      render 'edit'
    end
  end

  def new_qrcode
    room = Room.find(qrcode_params[:room_id])
    room.qrcode.destroy
    room.create_new_qr_code
    room.save
    @rooms = Room.all

    redirect_to rooms_path
  end

  def destroy
    room = Room.find(params[:id])

    if room.destroy
      flash[:notice] = "Room Deleted"
    else
      flash[:notice] = "Room Not Deleted"
    end
    redirect_to rooms_path
  end


  private
  def room_params
    params.require(:room).permit(:name, :house_id)
  end

  def qrcode_params
    params.require(:qrcode).permit(:room_id)
  end
end
