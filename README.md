# Brandon School Check-In Application

## Overview
This application is used to monitor overnight students.  QR codes are placed outside
of the doors of the student dorm rooms.  By scanning the QR code, the application
identifies how many students (beds actually) are in the room and need to be checked in on.

To begin the process, an overnight staff member creates a new tour.  To create a new tour
the staff member must identify which house they are in and upload a selfie to indicate
which staff member is conducting the tour.  Once this is completed, the staff member
is redirected to a QR code scanning page.  

Once the tour is started, the staff member has 20 minutes to complete the tour.  A
countdown timer is displaying how much time the staff member has left to complete the tour
before it is terminated and they have to start over.

The staff member then scans a QR code outside of one of the rooms and is presented with a
series of forms (one for each bed / student).  Information such as the students initials,
the students status (asleep, awake, off campus, etc.), and any relevant comments are entered
by the staff member. Once all forms are completed, the staff member is redirected to scan
another QR code.  This process continues until all the rooms in the current house have been
checked and the tour is complete.

An administrative user of the application has access to reporting capabilities to see
how many tours were created, what time they were created at, were the tours complete or incomplete,
and much more. Additionally, the administrative users have access to CRUD functionality for the
domain objects (house, room, and bed) to be able to manipulate and change the applications structure
based on the current houses are set up.  For example, beds often move in and out of rooms
which would require a different number of forms to be displayed for that room.  Admin's have the flexibility
to alter the application based on their current needs.
