
/************************************************************************
 * Page specific js
 ************************************************************************/
function main(tess) {
  "use strict";

  // get records and add to table
  // load rtypes into datatable
  $('table#dataTable').dataTable();

  $('button#btnInsert').click(function() {

    var recordType = new Object(null);
    recordType.id          = $("input#hidId").val();
    recordType.typeCode    = $("input#txtTypeCode").val();
    recordType.table       = $("select#drpTable").val();
    recordType.name        = $("input#txtName").val();
    recordType.description = $("input#txtDescription").val();
    recordType.active      = $("input#chkActive").val();
    recordType.modifyDate  = $("input#txtDateModified").val();

    var valid = true;
    var message = "";

    if (recordType.name.length >= 45 || recordType.name.length === 0) {
      valid = false;
      message += "Name invalid: Cannot be left blank.\n";
      tess.glowRed("input#txtName");
    }

    if (!tess.sanitize(recordType.name)) {
      valid = false;
      message += tess.sanitize(recordType.name);
      tess.glowRed("input#txtName");
    }

    $.get("/system/recordtypes/exists", recordType, function(data) {
      //valid = data;
      null;
    });

    if (!valid){
      window.alert(message);
    }

  });

}