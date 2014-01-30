
/************************************************************************
 * accounts view
 ************************************************************************/
  function viewMain (tess) {
  'use strict';

    // get records and add to table
    // load accounts into datatable
    // GET JSON URL: /accounting/accounts/json
    $("table#dataTable").dataTable();

    $("button#btnInsert").click(function() {
      var message = "";      

      var account = new Object(null);
      account.id          = $("input#txtId").val();
      account.name        = $("input#txtName").val();
      account.typeCode    = $("select#drpRType").val();
      account.modifyDate  = $("input#txtDateModified").val();
      //account.description = $("txtArea#txtDescription").val();

      // name
      if (!tess.required(account.name) || !tess.sanitize(account.name)) {
        tess.glowRed("input#txtName");
        message += "Invalid Name\n";
      }

      // typeCode
      if (!tess.required(account.typeCode)) {
        tess.glowRed("select#drpRType");
        message += "Record Type is Required\n";
      }

      if (message === "") { // valid user input

        // post to database

        $("table#dataTable").dataTable().fnAddData( [
          "account.id",
          "account.name",
          "account.typeCode",
          "account.modifyDate",
          "account.description"
        ]);

      }else{ 
        window.alert(message);
      }

    });

  }

/*
    $("table#dataTable").dataTable({
        "aaData": [
            [ "Trident", "Internet Explorer 4.0", "Win 95+", 4, "X" ],
            [ "Trident", "Internet Explorer 5.0", "Win 95+", 5, "C" ],
            [ "Trident", "Internet Explorer 5.5", "Win 95+", 5.5, "A" ],
            [ "Trident", "Internet Explorer 6.0", "Win 98+", 6, "A" ],
            [ "Trident", "Internet Explorer 7.0", "Win XP SP2+", 7, "A" ],
            [ "Gecko", "Firefox 1.5", "Win 98+ / OSX.2+", 1.8, "A" ],
            [ "Gecko", "Firefox 2", "Win 98+ / OSX.2+", 1.8, "A" ],
            [ "Gecko", "Firefox 3", "Win 2k+ / OSX.3+", 1.9, "A" ],
            [ "Webkit", "Safari 1.2", "OSX.3", 125.5, "A" ],
            [ "Webkit", "Safari 1.3", "OSX.3", 312.8, "A" ],
            [ "Webkit", "Safari 2.0", "OSX.4+", 419.3, "A" ],
            [ "Webkit", "Safari 3.0", "OSX.4+", 522.1, "A" ]
        ],
        "aoColumns": [
            { "sTitle": "Engine" },
            { "sTitle": "Browser" },
            { "sTitle": "Platform" },
            { "sTitle": "Version", "sClass": "center" },
            { "sTitle": "Grade", "sClass": "center" }
        ]
    }); */