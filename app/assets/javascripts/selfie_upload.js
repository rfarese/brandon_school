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
      url: "/selfie_upload",
      data: fd,
      processData: false,
      contentType: false
    });

    function showNewTourContainer(data) {
      $("#new-tour-container").show();
      $(".container").hide();
      $("#selfie-header").hide();
      $("#tour_id").val(data.tour_id);
    }

    request.done(function(data) {
      showNewTourContainer(data); 
    });
  });
});
