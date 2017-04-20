// $(document).ready(function() {
//   if (top.location.pathname === "/tours_in_progress" ) {
//     // get the tours-in-progress-container div
//     var recentToursContainer = $('.tours-in-progress-container')[0];
//     // clone the div
//     var newRecentToursContainer = $(recentToursContainer).clone();
//
//     let refreshToursInProgress = () => {
//       $.getJSON('/api/v1/tours_in_progress', function(data) {
//
//         $(".tours-in-progress-container").remove();
//         var houses = data.houses
//         buildNewToursInProgress(houses);
//         console.log("Refreshed Tours in Progress");
//         console.log(new Date(Date.now()));
//       });
//     }
//     // setInterval(refreshToursInProgress, 10000);
//   }
// });
