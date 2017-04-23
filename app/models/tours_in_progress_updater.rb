# Instead of building out the new HTML in the front end, we'll build it out on the backend
  # Use a series of utility classes to create the HTML
    # collect the tours_in_progress index page
    # create a new page with File.open("name_of_new_page", w)
    # remove the unneeded html

# scratch this thought above...
# we are going to create partils and build the page more efficiently
# then we can create an update.html.erb that calls the same partials and just pull that page...

class ToursInProgressUpdater
  attr_accessor :new_tours_html_elements, :file

  def initialize()
    @new_tours_html_elements = []
  end

  def get_file
    @file = File.read(Rails.root.to_s + "/app/views/tours_in_progress/index.html.erb")
  end

  def remove_elements
  end
end
