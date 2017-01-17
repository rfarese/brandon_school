$(document).ready(function() {
  $("body").on("click", ".student-check-submit-button", function(event) {
    event.preventDefault();
    var form = $(this).parent();
    var id = form.children("#student_check_id").attr("value");
    var status = form.find("#student_check_status option:selected").attr("value");
    var comment = form.find("#student_check_comment").val();
    var noticeElement = form.parent().find(".form-notice");
    debugger; 

    var request = $.ajax( {
      method: "PUT",
      url: "http://localhost:3000/update_student_checks",
      data: {
        student_check: {
          id: id,
          status: status,
          comment: comment
        }
      }
    });

    request.done(function(data) {
      formsSubmitted += 1

      if (formsSubmitted === studentQuantity) {
        location.reload();
        // update tour to specify that this room check is complete
        // check to see if there are any more rooms to check
        // if there are more rooms, refresh the current page
      }
      form.hide();
      noticeElement.append(data.notice);
    });
  });
});
