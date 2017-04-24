$(document).ready(function() {
  $("body").on("click", "#download-photo", function(event) {
    var dataURL = canvas.toDataURL('image/jpg');
    event.preventDefault();

    function dataURLtoBlob(dataURL) {
      var binary = atob(dataURL.split(',')[1]);
      var array = [];
      for(var i = 0; i < binary.length; i++) {
        array.push(binary.charCodeAt(i));
      }
      return new Blob([new Uint8Array(array)], {type: 'image/jpg'});
    }

    var file = dataURLtoBlob(dataURL);
    var fd = new FormData();
    fd.append("image", file);

    var request = $.ajax( {
      method: "POST",
      url: "/selfies",
      data: fd,
      processData: false,
      contentType: false
    });

    request.done(function(data) {
      console.log(data.errors);
      if (data.errors === "No errors") {
        location.href = data.selfie_id + "/tours/new"
      }
    });
  });
});
