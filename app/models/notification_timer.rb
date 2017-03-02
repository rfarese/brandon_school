class NotificationTimer
  # we need to know the when the last tour ended in a certain house
  # and if a new tour has been started in that house
  attr_reader :last_tour_end_time

  def initialize(args)
    @last_tour_end_time = args[:tour].updated_at
    @house = args[:tour].house 
  end
end
