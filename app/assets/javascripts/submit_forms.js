$(document).ready(function() {
  $("body").on("click", ".student-check-submit-button", function(event) {
    event.preventDefault();
    debugger;

    var form = this.parentElement
    var studentCheckId = form.children.student_check_id.value
    var request = $.ajax( {
    });

    request.done(function(data) {
    });

  });
});
