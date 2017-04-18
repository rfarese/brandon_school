$(document).ready(function() {
  if (top.location.pathname === "/tours_in_progress" ) {
    $.getJSON('/api/v1/tours_in_progress', function(data) {

      // Overview
        // data variable now has all of the data required to update the view in the proper heirarchial order
        // now we just need to iterate over the data and add the proper elements and classes to the DOM
        // then call this method on continuously with setInterval...

      // Steps
        // first remove the existing div that holds all the current tours in progress
          // $('.tours-in-progress-container').remove();
        // reconstruct a new tours-in-progress-container for each house
          //  iterate over the data variable
          var houses = data.houses

          Object.keys(houses).forEach(function(key) {
            // add house name as the title
            var toursInProgessContainer = "<div class='tours-in-progress-container'></div>"
            var houseTitleContainer = "<div class='row table-title-container'><div class='small-12 columns text-center'><h2 class='table-title'>";
            houseTitleContainer += key;
            houseTitleContainer += "</h2></div></div>";
            var updatedTitleContainer = $(toursInProgessContainer).append(houseTitleContainer);
            $('.tours-in-progress-top-container').append(updatedTitleContainer);

            // add tours-in-progress-house-container
            var toursInProgressHouseContainer = "<div class='tours-in-progress-house-container'></div>";

            // add tours-in-progress-header
            var toursInProgressHeader = "<div class='tours-in-progress-header'>";
            toursInProgressHeader += "<div class='small-3 small-offset-1 columns'>Tour Start Time</div>";
            toursInProgressHeader += "<div class='small-4 columns text-center'>Tour Status</div>";
            toursInProgressHeader += "<div class='small-4 columns text-center'>Tour Selfie</div>";
            toursInProgressHeader += "</div>";
            var updatedHouseContainer = $(toursInProgressHouseContainer).append(toursInProgressHeader);
            $(updatedTitleContainer).append(updatedHouseContainer)

            console.log(key, houses[key]);
          })

    });

  }
});

// data coming back is just the house data.  We need:
// [1] the current tours
// [2] which houses those tours are associated with
// [3] all the student checks associated with that tour


// In the regular view and controller we are using eager loading to add the additional required data
// in the ajax call and API, we don't have access to those eager loaded objects
// so we will create a presenter object that constructs the data into the proper structure
// so that we can recieve all the data we need in the structure we need it in
// See the Api::V1::ToursInProgressController for the details on how we need the data structured
