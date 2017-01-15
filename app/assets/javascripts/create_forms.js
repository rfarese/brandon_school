function addStudentToForm(student) {
  var studentInitialsElement = $(".student-initials");
  var studentInitials = student.initials
  var studentCheckIdElement = $("#student_check_id");
  studentInitialsElement.show();
  studentCheckIdElement.attr("value", student.check.id)
  studentInitialsElement.append(" " + studentInitials)
}

function createStudentForm(student) {
  var studentCheckContainer = $(".student-check-container").clone();
  debugger;
  // use removeClass() and addClass() in jquery to change the class name for the studentCheckContainer
  // then you can get the form based on the new class name in the submit forms ajax calls 
  studentCheckContainer.children("h2").text("Student: " + student.initials);
  studentCheckContainer.children("form").children("input#student_check_id").attr("value", student.check.id);
  studentCheckContainer.appendTo(".main-content-container");
}
