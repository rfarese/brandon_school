$(document).ready(function() {
  if (top.location.pathname === "/tours_in_progress" ) {
    let refreshToursInProgress = () => {
      $.getJSON('/api/v1/tours_in_progress', function(data) {

        $(".tours-in-progress-container").remove();
        var houses = data.houses
        buildNewToursInProgress(houses);
        console.log("Refreshed Tours in Progress");
        console.log(new Date(Date.now()));
      });
    }
    // setInterval(refreshToursInProgress, 10000);
  }
});
