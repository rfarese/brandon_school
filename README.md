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

Reports Strategy
- Report class
- have a form on the index page where the user chooses from a series of dropdowns for each model
- all the forms dropdowns are greyed out until the previous one is chosen (you need to choose which house before you choose the rooms or beds or students, etc.)
- Step #1 - user selects one house, all houses, or a group of houses (group of houses could be tough...)
- Step #2 - user selects all, complete, or incomplete check-ins (from student checks) that are associated with the house(s) they chose 
- Step #3 - user selects the student_check status's they want to pull (all, asleep, awake, etc.)
- Step #4 - user selects the date ranges (do this last)
- each step is a GET request and it'll return all the objects for that resource
  - when user clicks on "Houses", have a pop up come up
  - user will be presented with a series of houses to choose from and click a submit button
  - the controller will return all the houses along with all the rooms associated with that house
  - now the rooms dropdown will be activated...the user will click on rooms, see a pop up of all the rooms, and the process will repeat until the correct data is returned to the user and displayed in the dashboard
