$(document).ready(function () {
  if (top.location.pathname === "/reports" ) {
    $("#panel1").find("input:checkbox").prop("checked", true); 
    $("#panel3").find("input:checkbox").prop("checked", true);
  }
});
