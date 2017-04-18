$(document).ready(function() {
  if (top.location.pathname === "/tours_in_progress" ) {
    $.getJSON('/api/v1/tours_in_progress', function(data) {
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
