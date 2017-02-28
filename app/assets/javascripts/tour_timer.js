$(document).ready(function() {
  if (top.location.pathname === "/tours" || top.location.pathname == "/generate_student_checks") {
    // set the time we are counting down too
    var tourStartTime = $(".tour-time").text();

    var initialDate = new Date(tourStartTime);
    var tourEndTime = new Date(initialDate.getTime() + (1*60*1000));

    // Update the count down every second
    var x = setInterval(function(){
      // Get todays date and time
      var now = new Date().getTime();

      // find the distance between now and the tour end time
      var distance = tourEndTime - now;

      // Time calculations for days, hours, minutes, and seconds
      var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
      var seconds = Math.floor((distance % (1000 * 60)) / 1000);

      // Display the results in the element with id='demo'
      document.getElementById("demo").innerHTML = minutes + " Minutes " + seconds + " Seconds ";

      // If the count down is finished, redirect to root path and display message that the tour has expired

      if (distance < 0) {
        clearInterval(x);
        $(".notice").append("Tour has expired");
        $(".main-content-container").hide();
        $(".footer").hide();
      }
    });
  }
});
