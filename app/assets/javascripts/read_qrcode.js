function generateStudentCheckButton(identifier) {
	var button = $("#generate-student-check-button");
	var path = button.attr("href");
	path += "&qrcode_identifier=" + identifier
	button.attr("href", path);
	button.show();
}

function onSuccess(data) {
	document.getElementById('video').setAttribute("style", "border: 3px solid #52e250");
	console.log('Sucess:', data);
	generateStudentCheckButton(data)
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
