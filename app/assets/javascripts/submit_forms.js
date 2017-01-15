$(document).ready(function() {
  $("body").on("click", ".student-check-submit-button", function(event) {
    event.preventDefault();
    var form = $(this).parent();
    var id = form.children("#student_check_id").attr("value");
    var status = form.find("#student_check_status option:selected").attr("value");
    var comment = form.find("#student_check_comment").val();
    var noticeElement = form.parent().find(".form-notice");

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
      // figure out if all the forms have been completed
        // if so, then send a get request to scan a new QR code 
      form.hide();
      noticeElement.append(data.notice);
      roomComplete
    });
  });
});
