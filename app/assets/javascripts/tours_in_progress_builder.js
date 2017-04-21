function buildNewToursInProgress(houses) {
  for(var housesCount = 0; housesCount < houses.length; housesCount++) {
    var house = houses[housesCount];
    var tours = house.tours;
    var toursInProgessContainer = "<div class='tours-in-progress-container'></div>"
    var houseTitleContainer = "<div class='row table-title-container'><div class='small-12 columns text-center'><h2 class='table-title'>";
    houseTitleContainer += house.name;
    houseTitleContainer += "</h2></div></div>";
    var updatedToursInProgress = $(toursInProgessContainer).append(houseTitleContainer);
    $('.tours-in-progress-top-container').append(updatedToursInProgress);

    var toursInProgressHouseContainer = "<div class='tours-in-progress-house-container'></div>";

    // add tours-in-progress-header
    var toursInProgressHeader = "<div class='row tours-in-progress-header'>";
    toursInProgressHeader += "<div class='small-3 small-offset-1 columns'>Tour Start Time</div>";
    toursInProgressHeader += "<div class='small-4 columns text-center'>Tour Status</div>";
    toursInProgressHeader += "<div class='small-4 columns text-center'>Tour Selfie</div>";
    toursInProgressHeader += "</div>";
    var updatedHouseContainer = $(toursInProgressHouseContainer).append(toursInProgressHeader);
    $(updatedToursInProgress).append(updatedHouseContainer);
    addTours(tours, updatedHouseContainer);
  }
}

function createTourDate(dateTime) {
  var year = dateTime.slice(0,4);
  var month = dateTime.slice(5,7) - 1;
  var day = dateTime.slice(8,10);
  var hour = dateTime.slice(11,13);
  var minute = dateTime.slice(14,16);
  var tourDate = new Date(year, month, day, hour, minute);
  return tourDate.toString().slice(4,21);
}


function addTours(tours, updatedHouseContainer) {
// function addTours(tours, updatedHouseContainer) {
  for(var tourCount = 0; tourCount < tours.length; tourCount++) {
    var tour = tours[tourCount];
    var tourDate = createTourDate(tour.start_time);
    var displayTourDetails = "<a href='" + tour.id + "-details' class='display-tour-details'></a>"
    var tourData = "<div class='row tours-in-progress'>";
    tourData += "<div class='small-3 small-offset-1 columns tour-info'>";
    tourData += tourDate + "</div>";
    tourData += "<div class='small-4 columns tour-info text-center'>" + tour.status + "</div>";
    tourData += "<div class='small-4 columns text-center selfie-container'>";
    tourData += "<img src=" + tour.selfie + " width='100' height='100'></div></div>";
    var updatedTourDetails = $(displayTourDetails).append(tourData);
    $(updatedHouseContainer).append(updatedTourDetails);

    // create headers for bed checks / student checks
    var bedCheckContainer = "<div class='row tours-in-progress-details' id='tour" + tour.id + "-details'></div>";
    var bedCheckTitle = "<h4 class='text-center'>Bed Checks</h4>";
    var updatedBedCheckContainer = $(bedCheckContainer).append(bedCheckTitle);
    var bedCheckHeader = "<div class='row tours-in-progress-details-headers'>";
    bedCheckHeader += "<div class='small-3 small-offset-1 columns bed-check-details-initials-header'>Initials</div>";
    bedCheckHeader += "<div class='small-4 columns text-center'>Status</div>";
    bedCheckHeader += "<div class='small-4 columns text-center'>Comment</div></div>";
    updatedBedCheckContainer = $(updatedBedCheckContainer).append(bedCheckHeader);
    $(updatedTourDetails).append(updatedBedCheckContainer);
    addStudentChecks(tour.student_checks, updatedBedCheckContainer);
  }
}

function addStudentChecks(studentChecks, updatedBedCheckContainer) {
  for(var studentCheckCount = 0; studentCheckCount < studentChecks.length; studentCheckCount++) {
    var studentCheck = studentChecks[studentCheckCount];
    var studentInitials = function() {
      if (studentCheck.initials == null) {
        return " - "
      } else {
        return studentCheck.initials
      };
    };

    var studentComment = function() {
      if (studentCheck.comment === null || studentCheck.comment === "") {
        return " - "
      } else {
        return studentCheck.comment
      };
    };

    var studentCheckData = "<div class='row'>";
    studentCheckData += "<div class='small-3 small-offset-1 columns bed-check-details-initials'>" + studentInitials() + "</div>";
    studentCheckData += "<div class='small-4 columns text-center'>" + studentCheck.status + "</div>";
    studentCheckData += "<div class='small-4 columns text-center'>" + studentComment() + "</div></div>";
    $(updatedBedCheckContainer).append(studentCheckData);
  }
}
