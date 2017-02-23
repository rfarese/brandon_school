# Brandon School
Your app description, here.

Todo:  

Remove instance variables from student_checks forms partial
- remove the @student_checks and @tour by passing in locals

Refactor current_tour in ApplicationController
- move this into StudentChecksController (its not being used by other controllers...)

Refactor Models
- go through each model
- check how they are relating to each other
- some of the initial relationships weren't necessary while others were necessary
- there are probably several methods and relationships in different models that could be removed

Clean up routes
- go through all the routes you aren't using (including devise) and remove them

Fix Mobile Views
- go through each page and fix the view bugs on mobile and tablets

Reports
- ensure that only admins can reach the reports page
- in the reports, an unfinished tour doesn't report that a student hasn't been checked on.
  This is because we are creating a student_check when the qr code is scanned instead of
  creating all the student checks for the given tour when the tour starts.
- add ability to export report in a CSV file
- add pagination to reports
