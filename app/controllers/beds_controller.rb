class BedsController < ApplicationController
  before_action :authorize_admin

  def index
    @beds = Bed.all
    @beds = Kaminari.paginate_array(@beds).page(params[:page]).per(7)
  end

  def new
    @bed = Bed.new
    @rooms = Room.all
  end

  def create
    @bed = Bed.new(bed_params)
    if @bed.save
      flash[:notice] = "New Bed Saved"
      redirect_to beds_path
    else
      flash[:notice] = "Please provide valid information."
      @houses = House.all
      @rooms = Room.all
      render "new"
    end
  end

  def show
  end

  def edit
    @bed = Bed.find(params[:id])
    @rooms = Room.all
  end

  def update
    @bed = Bed.find(params[:id])
    if @bed.update(bed_params)
      flash[:notice] = "Bed Updated"
      redirect_to beds_path
    else
      flash[:notice] = "Please provide valid information."
      @houses = House.all
      @rooms = Room.all
      render 'edit'
    end
  end


  def destroy
    bed = Bed.find(params[:id])
    if bed.destroy
      flash[:notice] = "Bed Deleted"
    else
      flash[:notice] = "Bed Not Deleted"
    end
    redirect_to beds_path
  end


  private

  def bed_params
    params.require(:bed).permit(:name, :room_id)
  end
end
