function allFormsComplete() {

}

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
      formsSubmitted += 1

      if (data.tour_complete === true) {
        window.location.pathname = "/"
      } else {
        if (formsSubmitted === studentQuantity) {
          location.reload();
          // when we reload, we are creating a new tour...which is not right
          // we need to redirect to a new qr code scan 
        }
      }

      form.hide();
      noticeElement.append(data.notice);
    });
  });
});
