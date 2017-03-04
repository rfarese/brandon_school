$(document).ready(function() {
  $("body").on("click", "#download-photo", function(event) {
    $("#new-tour-container").show();
    $(".container").hide();
    $("#selfie-header").hide(); 
  });
});
