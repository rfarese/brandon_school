# Brandon School
Your app description, here.

Todo:  

Remove @student_checks and @tour from the partial 'student_checks/forms'
- you should never be using an instance variable in a partial
- instead, pass in locals and render like so:
  def new
    ...
    student_checks = generate_student_checks.generate
    render 'new', locals: { student_checks: student_checks }
  end
- this needs to happen in both the #new and #update actions in the StudentChecksController
- Note - not sure if I'd also have to have the following when I call render in the view...
  <%= render 'form', student_checks: student_checks %>
- You may want to look at creating a helper method for getting the tour 

Create a RoomCheck class
- doesn't have to be a domain object; just a plain old ruby object (poro)
- determine if the room is finished being checked
  - How? By checking to see if the number of student checks equals the number
    of students in the room
  - in order to do this we may need:
    - the number of beds in the room
    - the number of students in the room? (this is really the important info
    but we might need the bed to find the student...)

Remove #status column from Tours table
- add #complete column to Tour class instead of the #status column
- make the #complete column in the db boolean (true or false)
- create a #completer method:
  - purpose of this method is to know if the Tour is complete or not by comparing
    the number of completed rooms to the number of
  - knows how many rooms there are in the house to check
  - knows how many rooms have been completed

Create a TourStatusCreator Poro class
- instantiate by passing in a
