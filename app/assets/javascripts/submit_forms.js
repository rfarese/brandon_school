$(document).ready(function() {
  // $("body").on("click", ".student-check-submit-button", function(event) {

  $( "form" ).submit(function( event ) {
    debugger;
    var form_data = ( $( this ).serializeArray() );
    event.preventDefault();

    var id = form_data[1].value
    var status = form_data[2].value
    var comment = form_data[3].value

    for (var i=0; i < form_data.length; i++) {
      if (form_data[i].name === "student_check[id]") {
        id = form_data[i].value
      } else if (form_data[i].name === "student_check[status]") {
        status = form_data[i].value
      } else if (form_data[i].name === "student_check[comment]") {
        comment = form_data[i].value
      }
    };

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
      debugger;
      // hide form; display success message

      console.log(data.notice)
    });

  });
});
