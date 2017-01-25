class HousesController < ApplicationController
  def index
    @houses = House.all
  end

  def new
    @house = House.new
  end

  def create
    @house = House.new(house_params)
    if @house.save
      flash[:notice] = "New House Saved"
      redirect_to houses_path
    else
      flash[:notice] = "House Not Saved"
      render 'new'
    end
  end

  def edit
    @house = House.find(params[:id])
  end

  def update
    @house = House.find(params[:id])
    if @house.update(house_params)
      flash[:notice] = "House Edited"
      redirect_to houses_path
    else
      flash[:notice] = "House Not Edited"
      render 'edit'
    end
  end

  private
  def house_params
    params.require(:house).permit(:name)
  end
end
