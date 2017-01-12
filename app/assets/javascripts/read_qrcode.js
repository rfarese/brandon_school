function makeAjaxCall(room_identifier) {
	var request = $.ajax( {
	  method: "POST",
	  url: "http://localhost:3000/api/v1/some_end_point",
		data: {
			tour: {
				room_id: room_identifier
			}
		}
	});

	request.done(function(data) {
		$("#decoded-room-id").append(data.room_id);
		$("#decoded-room-name").append(data.room_name);
		$("#decoded-house-name").append(data.house_name);
	});
}

function onSuccess(data) {
		document.getElementById('video').setAttribute("style", "border: 3px solid #52e250");
		console.log('Sucess:', data);
		// makeAjaxCall(data);
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
