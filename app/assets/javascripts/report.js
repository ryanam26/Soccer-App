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
                "sPdfMessage": "Team Report"
            },
            {
                "sExtends": "print",
                "bSelectedOnly": true,
                "oSelectorOpts": { filter: 'applied', order: 'current' },
            }
            ],
            
        },"aLengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
        "iDisplayLength": -1
      });
    $(".DTTT").addClass("pull-right");    

} );