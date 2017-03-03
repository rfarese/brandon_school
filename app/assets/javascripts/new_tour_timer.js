$(document).ready(function() {
  // need to rethink this...
  // probably need a request sent when the user lands on the homepage
  // the request will collect the 

  if (top.location.pathname === "/") {
    var houseName = $(".house-name").text();
    var tourEndTime = $(".tour-end-time").text();

    var initialDate = new Date(tourEndTime);
    var tourStartTime = new Date(initialDate.getTime() + (10*60*1000));

    var x = setInterval(function(){
      var now = new Date().getTime();
      var distance = tourStartTime - now;
      var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
      var seconds = Math.floor((distance % (1000 * 60)) / 1000);
      document.getElementById("new-tour-countdown").innerHTML = minutes + " Minutes " + seconds + " Seconds ";

      if (distance < 0) {
        clearInterval(x);
        // send house name with AJAX request back to the NotificationEmailsController#new
        $.post("/new_notification", { house_name: houseName })

        // these should happen when the AJAX request has been recieved
        // $(".notice").append("Management has been notified");
        // $(".main-content-container").hide();
        // $(".footer").hide();
      }
    });
  }
});
