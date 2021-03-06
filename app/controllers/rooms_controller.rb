class RoomsController < ApplicationController
  before_action :authorize_admin

  def index
    @rooms = Room.includes(:house, :qrcode).all
    @rooms = Kaminari.paginate_array(@rooms).page(params[:page]).per(7)
  end

  def new
    @room = Room.new
    @houses = House.all
  end

  def create
    @room = Room.new(room_params)
    @room.qrcode_identifier = generate_qrcode_identifier

    if @room.save
      QrcodeCreator.new(@room).generate
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

  def generate_qrcode_identifier
    num = Room.maximum(:qrcode_identifier) || 1
    num + 1
  end
end
