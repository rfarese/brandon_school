$(document).ready(function() {
  $("body").on("click", ".display-tour-details", function(event) {
    var tourDetails = $(this).find(".tours-in-progress-details");

    if (tourDetails.css("display") === "none") {
      tourDetails.slideDown();
    } else {
      tourDetails.slideUp();
    }
  });
});
