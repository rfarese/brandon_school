let buildNewToursInProgress = (houses) => {
  for(let housesCount = 0; housesCount < houses.length; housesCount++) {
    let house = houses[housesCount];
    let tours = house.tours;
    let toursInProgessContainer = "<div class='tours-in-progress-container'></div>"
    let houseTitleContainer = "<div class='row table-title-container'><div class='small-12 columns text-center'><h2 class='table-title'>";
    houseTitleContainer += house.name;
    houseTitleContainer += "</h2></div></div>";
    let updatedToursInProgress = $(toursInProgessContainer).append(houseTitleContainer);
    $('.tours-in-progress-top-container').append(updatedToursInProgress);

    let toursInProgressHouseContainer = "<div class='tours-in-progress-house-container'></div>";

    // add tours-in-progress-header
    let toursInProgressHeader = "<div class='row tours-in-progress-header'>";
    toursInProgressHeader += "<div class='small-3 small-offset-1 columns'>Tour Start Time</div>";
    toursInProgressHeader += "<div class='small-4 columns text-center'>Tour Status</div>";
    toursInProgressHeader += "<div class='small-4 columns text-center'>Tour Selfie</div>";
    toursInProgressHeader += "</div>";
    let updatedHouseContainer = $(toursInProgressHouseContainer).append(toursInProgressHeader);
    $(updatedToursInProgress).append(updatedHouseContainer);
    addTours(tours, updatedHouseContainer);
  }
}

let createTourDate = (dateTime) => {
  let year = dateTime.slice(0,4);
  let month = dateTime.slice(5,7) - 1;
  let day = dateTime.slice(8,10);
  let hour = dateTime.slice(11,13);
  let minute = dateTime.slice(14,16);
  let tourDate = new Date(year, month, day, hour, minute);
  return tourDate.toString().slice(4,21);
}


let addTours = (tours, updatedHouseContainer) => {
// function addTours(tours, updatedHouseContainer) {
  for(let tourCount = 0; tourCount < tours.length; tourCount++) {
    let tour = tours[tourCount];
    let tourDate = createTourDate(tour.start_time);
    let displayTourDetails = "<a href='" + tour.id + "-details' class='display-tour-details'></a>"
    let tourData = "<div class='row tours-in-progress'>";
    tourData += "<div class='small-3 small-offset-1 columns tour-info'>";
    tourData += tourDate + "</div>";
    tourData += "<div class='small-4 columns tour-info text-center'>" + tour.status + "</div>";
    tourData += "<div class='small-4 columns text-center selfie-container'>";
    tourData += "<img src=" + tour.selfie + " width='100' height='100'></div></div>";
    let updatedTourDetails = $(displayTourDetails).append(tourData);
    $(updatedHouseContainer).append(updatedTourDetails);

    // create headers for bed checks / student checks
    let bedCheckContainer = "<div class='row tours-in-progress-details' id='tour" + tour.id + "-details'></div>";
    let bedCheckTitle = "<h4 class='text-center'>Bed Checks</h4>";
    let updatedBedCheckContainer = $(bedCheckContainer).append(bedCheckTitle);
    let bedCheckHeader = "<div class='row tours-in-progress-details-headers'>";
    bedCheckHeader += "<div class='small-3 small-offset-1 columns bed-check-details-initials-header'>Initials</div>";
    bedCheckHeader += "<div class='small-4 columns text-center'>Status</div>";
    bedCheckHeader += "<div class='small-4 columns text-center'>Comment</div></div>";
    updatedBedCheckContainer = $(updatedBedCheckContainer).append(bedCheckHeader);
    $(updatedTourDetails).append(updatedBedCheckContainer);
    addStudentChecks(tour.student_checks, updatedBedCheckContainer);
  }
}

let addStudentChecks = (studentChecks, updatedBedCheckContainer) => {
  for(let studentCheckCount = 0; studentCheckCount < studentChecks.length; studentCheckCount++) {
    let studentCheck = studentChecks[studentCheckCount];
    let studentInitials = function() {
      if (studentCheck.initials == null) {
        return " - "
      } else {
        return studentCheck.initials
      };
    };

    let studentComment = function() {
      if (studentCheck.comment === null || studentCheck.comment === "") {
        return " - "
      } else {
        return studentCheck.comment
      };
    };

    let studentCheckData = "<div class='row'>";
    studentCheckData += "<div class='small-3 small-offset-1 columns bed-check-details-initials'>" + studentInitials() + "</div>";
    studentCheckData += "<div class='small-4 columns text-center'>" + studentCheck.status + "</div>";
    studentCheckData += "<div class='small-4 columns text-center'>" + studentComment() + "</div></div>";
    $(updatedBedCheckContainer).append(studentCheckData);
  }
}
