class Api::V1::ToursInProgressController < Api::V1::ApiController
  def index
    houses = House.tours_today
    render json: houses
  end

  private
  def set_tours(houses)
    tours = []
    houses.each do |house|

    end
  end

end


# what do we need the data to look like?
# {
#   houses: {
#     houseName: {
#       tours: [
#         {
#           start_time: tour.created_at,
#           status: tour.status,
#           selfie: tour.selfie
#           student_checks: [
#             {
#               initials: student_check.initials,
#               status: student_check.status,
#               comment: student_check.comment
#             },
#             {
#               initials: student_check.initials,
#               status: student_check.status,
#               comment: student_check.comment
#             }
#           ]
#         },
#         {
#           start_time: tour.created_at,
#           status: tour.status,
#           selfie: tour.selfie
#           student_checks: [
#             {
#               initials: student_check.initials,
#               status: student_check.status,
#               comment: student_check.comment
#             }
#           ]
#         }
#       ]
#     }
#   }
# }
