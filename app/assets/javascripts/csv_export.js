$(document).ready(function () {
  if (top.location.pathname === "/report_filters" ) {

    $(".csv-download-container").show();

    function exportTableToCSV($table, filename) {
      var $headers = $table.find('tr:has(th)'),
          $rows = $table.find('tr:has(td)'),
          tmpColDelim = String.fromCharCode(11),
          tmpRowDelim = String.fromCharCode(0),
          colDelim = '","',
          rowDelim = '"\r\n"';

      var csv = '"';
          csv += formatRows($headers.map(grabRow));
          csv += rowDelim;
          csv += formatRows($rows.map(grabRow)) + '"';

      var csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csv);

      $(this).attr({
        'download': filename,
        'href': csvData
      });

      function formatRows(rows) {
        return rows.get().join(tmpRowDelim)
        .split(tmpRowDelim).join(rowDelim)
        .split(tmpColDelim).join(colDelim);
      }

      function grabRow(i,row){
        var $row = $(row);
        var $cols = $row.find('td');
        if(!$cols.length) $cols = $row.find('th');
        return $cols.map(grabCol).get().join(tmpColDelim);
      }

      function grabCol(j,col){
        var $col = $(col),
            $text = $col.text();
        return $text.replace('"', '""');
      }
    }

    $("#export").click(function (event) {
      var outputFile = window.prompt("What do you want to name your output file (Note: This won't have any effect on Safari)") || 'export';
      outputFile = outputFile.replace('.csv','') + '.csv'
      exportTableToCSV.apply(this, [$('#report-results-table'), outputFile]);
    });
  }
});
