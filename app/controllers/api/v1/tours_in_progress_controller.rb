class Api::V1::ToursInProgressController < Api::V1::ApiController
  def index
    houses = House.tours_today
    presenter = ToursInProgressPresenter.new(houses)
    presenter.build_data
    data = presenter.data
    render json: { houses: data }
  end
end

# data
  # {
  #   houses: [
  #     {
  #       name: "House1",
  #       tours: [
  #         {
  #           id: "15",
  #           start_time: "2017-04-19 15:33",
  #           status: "complete",
  #           selfie: "https://brandon-school-development.s3.amazonaws.com...",
  #           student_checks: [
  #             {
  #               initials: "UU",
  #               status: "asleep",
  #               comment: "UU is asleep"
  #             },
  #             {
  #               initials: "TT",
  #               status: "awake",
  #               comment: "TT is awake and studying"
  #             },
  #             {
  #               initials: "ZZ",
  #               status: "asleep",
  #               comment: "ZZ is catching some Z's"
  #             }
  #           ]
  #         },
  #         {
  #           id: "16",
  #           start_time: "2017-04-20 20:15",
  #           status: "complete",
  #           selfie: "https://brandon-school-development.s3.amazonaws.com...",
  #           student_checks: [
  #             {
  #               initials: "UU",
  #               status: "missing",
  #               comment: "UU is missing!"
  #             },
  #             {
  #               initials: "TT",
  #               status: "awake",
  #               comment: "TT is awake and studying"
  #             },
  #             {
  #               initials: "ZZ",
  #               status: "awake",
  #               comment: "ZZ is studying with TT"
  #             }
  #           ]
  #         }
  #       ]
  #     },
  #     {
  #       name: "House2",
  #       tours: [
  #         {
  #           id: "20",
  #           start_time: "2017-04-19 15:40",
  #           status: "complete",
  #           selfie: "https://brandon-school-development.s3.amazonaws.com...",
  #           student_checks: [
  #             {
  #               initials: "QQ",
  #               status: "asleep",
  #               comment: "QQ is asleep"
  #             },
  #             {
  #               initials: "EE",
  #               status: "awake",
  #               comment: "EE is awake and studying"
  #             },
  #             {
  #               initials: "NN",
  #               status: "asleep",
  #               comment: "NN is catching some Z's"
  #             }
  #           ]
  #         },
  #         {
  #           id: "25",
  #           start_time: "2017-04-20 20:30",
  #           status: "complete",
  #           selfie: "https://brandon-school-development.s3.amazonaws.com...",
  #           student_checks: [
  #             {
  #               initials: "II",
  #               status: "missing",
  #               comment: "II is missing!"
  #             },
  #             {
  #               initials: "VV",
  #               status: "awake",
  #               comment: "VV is awake and studying"
  #             },
  #             {
  #               initials: "OO",
  #               status: "awake",
  #               comment: "OO is studying with VV"
  #             }
  #           ]
  #         }
  #       ]
  #     }
  #   ]
  # }
