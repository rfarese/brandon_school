$(document).ready(function() {
  if (top.location.pathname === "/report_filters" ) {
    // collect the report results into a series of variables
    var unsplitHeaders = $("#report-results-table").find("th").text();
    var headers = unsplitHeaders.split(" "); 
  }
});
