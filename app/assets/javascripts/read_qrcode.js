function generateStudentChecks(room_identifier) {
	var request = $.ajax( {
	  method: "POST",
	  url: "http://localhost:3000/generate_student_checks",
		data: {
			student_check: {
				room_id: room_identifier
			}
		}
	});

	request.done(function(data) {
		var students = data.student_checks
		studentQuantity = students.length
		formsSubmitted = 0; 
		var form = $(".student-check-form");
		form.show();

		for (var i = 0; i < students.length; i++) {
			student = students[i]
			if (i === 0 ) {
				addStudentToForm(student)
			} else {
				createStudentForm(student)
			};
		};
	});
}

function onSuccess(data) {
		document.getElementById('video').setAttribute("style", "border: 3px solid #52e250");
		console.log('Sucess:', data);
		generateStudentChecks(data)
}

function onError(err) {
		console.error(err);
}

$(document).ready(function() {
	QrReader.getBackCamera().then(function(device) {
		new QrReader({
				sucessCallback: onSuccess, // Required
				errorCallback: onError, // Required
				videoSelector: '#video', // If not provided creates an invisible element and decode in background
				stopOnRead: true, // Default false, When true the video will stop once the first QR is read.
				deviceId: device.deviceId, // Id of the device used for recording video.
		});
	});
});
