$(document).ready(function() {
    var table = $('.datetable').dataTable( {
        "dom": 'T<"clear">lfrtip',
        "tableTools": {
        "sSwfPath": "/swf/copy_csv_xls_pdf.swf",
        "sRowSelect": "multi",
        "aButtons": [
            {
                "sExtends": "copy",
                "bSelectedOnly": true,
                "oSelectorOpts": { filter: 'applied', order: 'current' }
            },
            {
                "sExtends": "xls",
                "bSelectedOnly": true,
                "oSelectorOpts": { filter: 'applied', order: 'current' },
                "sFileName": "Team Report.xls"
            },
            {
                "sExtends": "pdf",
                "bSelectedOnly": true,
                "oSelectorOpts": { filter: 'applied', order: 'current' },
                "sFileName": "Team Report.pdf",
                "sTitle": $('#team_name').length ? $('#team_name').val() : ' ',
                "sPdfMessage": $('#test_name').val()
            },
            {
                "sExtends": "print",
                "bSelectedOnly": true,
                "oSelectorOpts": { filter: 'applied', order: 'current' }
            }
            ]
            
        },
        "aLengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
        "iDisplayLength": 50
      });
    $(".DTTT").addClass("pull-right");

} );