$(document).ready(function() {
  if (top.location.pathname === "/tours" || top.location.pathname == "/generate_student_checks" || top.location.pathname.includes("/student_checks/")) {
    var tourStartTime = $(".tour-time").text();

    var initialDate = new Date(tourStartTime);
    var tourEndTime = new Date(initialDate.getTime() + (20*60*1000));

    var x = setInterval(function(){
      var now = new Date().getTime();
      var distance = tourEndTime - now;
      var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
      var seconds = Math.floor((distance % (1000 * 60)) / 1000);
      document.getElementById("countdown").innerHTML = minutes + " Minutes " + seconds + " Seconds ";

      if (distance < 0) {
        clearInterval(x);
        $(".notice").append("Tour has expired");
        $(".main-content-container").hide();
        $(".footer").hide();
      }
    });
  }
});
