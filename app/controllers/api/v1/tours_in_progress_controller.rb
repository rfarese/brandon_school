class Api::V1::ToursInProgressController < Api::V1::ApiController
  def index
    houses = House.tours_today
    presenter = ToursInProgressPresenter.new(houses)
    presenter.build_data
    data = presenter.data
    render json: { houses: data }
  end
end
