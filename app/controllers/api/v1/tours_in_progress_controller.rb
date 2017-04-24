class Api::V1::ToursInProgressController < Api::V1::ApiController
  # def index
  #   houses = House.tours_today
  #   presenter = ToursInProgressPresenter.new(houses)
  #   presenter.build_data
  #   data = presenter.data
  #   render json: { houses: data }
  # end

  def index
    @houses = House.tours_today
    render json: {
      attachmentPartial:
        render_to_string(
        partial: 'tours_in_progress/update_tours',
        formast: :html,
        layout: false,
        locals: { houses: @houses }
        )
      }
  end
end
