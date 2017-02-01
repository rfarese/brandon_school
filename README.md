# Brandon School
Your app description, here.

Todo:  

Remove instance variables from student_checks forms partial
- remove the @student_checks and @tour by passing in locals

Refactor current_tour in ApplicationController
- move this into StudentChecksController (its not being used by other controllers...)

Create a RoomCheck class
- doesn't have to be a domain object; just a plain old ruby object (poro)
- determine if the room is finished being checked
  - How? By checking to see if the number of student checks equals the number
    of students in the room
  - in order to do this we may need:
    - the number of beds in the room
    - the number of students in the room? (this is really the important info
    but we might need the bed to find the student...)

Tours table
- create a #completer method:
  - purpose of this method is to know if the Tour is complete or not by comparing
    the number of completed rooms to the number of
  - knows how many rooms there are in the house to check
  - knows how many rooms have been completed

Refactor Models
- go through each model
- check how they are relating to each other
- some of the initial relationships weren't necessary while others were necessary
- there are probably several methods and relationships in different models that could be removed

Clean up routes
- go through all the routes you aren't using (including devise) and remove them

Fix Mobile Views
- go through each page and fix the view bugs on mobile and tablets
