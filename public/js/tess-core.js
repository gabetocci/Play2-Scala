
/************************************************************************
 * TESS Core Library
 ************************************************************************/
var tess = function () {
  'use strict';

  /************************************************************************
   * Private Properties
   ************************************************************************/
  var currentPath = $(location).attr('pathname');
  var currentDate = new Date();



  /************************************************************************
   * Private Functions
   ************************************************************************/


  return {

    /************************************************************************
     * Public Properties
     ************************************************************************/
    currentPath: $(location).attr('pathname'),
    currentDate: new Date(),

    /************************************************************************
     * Public Functions
     ************************************************************************/

    // UI

    setActiveNavItem: function (currentPath) {
      $("li.nav-item").each( function(){
        var navItemPath = $(this).find("a").attr('href');
        if (navItemPath === currentPath) {
          $(this).addClass("active");
        }
      });
    },
/*
	// TODO
    showPopup: function (popup_selector) {
      $("#popup_background").css({"opacity":"0.4"});
      $("#popup_background").fadeIn("slow");
      $(popup_selector).fadeIn('fast');
      window.scroll(0,0);
    },
    hidePopup: function (popup_selector) {
      $("#popup_background").click(function(){
        $(popup_selector).hide();
        $("#popup_background").fadeOut("slow");
      });
    },
*/

    /************************************************************************
     * Form Validation
     ************************************************************************/
    glowRed: function (selector) {
      $(selector)
        .addClass("error-input")
        .focus(function () {
          $(this).removeClass("error-input");
        });
    },

    checkable: function( element ) {
      return (/radio|checkbox/i).test(element.type);
    },

    sanitize: function (val) {
      var badChars = '!@#$%^&*()+~`=-[];,./{}|:<>?';
      for (var i = 0; i < val.length; i++) {
        if (badChars.indexOf(val.charAt(i)) !== -1) {
          //result  = "Invalid character found: "+ val.charAt(i) + "\n";
          //result += "Following characters are not allowed: " + badChars;
          return false;
        }
      }
      return true;
    },

    required: function(val) {
      return $.trim(val).length > 0;
    },

/*
    existsAlready: function (obj, url, result) {

      var result = true;
      var list = $.get(url, data, success);

      $.each(list, function(admin, value) {
        window.alert(admin + ': ' + value);
        if (value === obj) {

        }
      });

      return result;
    },
*/
    postObject: function (obj, url) {
      $.ajax({
        type: "POST",
        url: url,
        data: JSON.stringify(obj),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response){
          return(response);
        },
        error: function (xhr, ajaxOptions, thrownError){
          window.alert(thrownError);
        }
      });
    },

    addRowToTable: function (obj) {
      $('table#dataTable').dataTable().fnAddData([
        obj.id,
        '<div id="pop-up-'+obj.name+'" class="pop-up" >'+ obj.description +'</div>' +
        '<div id="pop-up-trigger-'+obj.name+'">'+ obj.name +'</div>',
        obj.rtype,
        obj.modifyDate
      ]);
      addPopup(obj.id);
    },

    addPopup: function (id) {
      $('div#pop-up-trigger-'+id).hover(
        function(e) {
          $('div#pop-up-'+id).show()
            .css('top',  e.pageY + 20)
            .css('left', e.pageX + 10)
            .appendTo('body');
        }, function() {
          $('div#pop-up-'+id).hide();
        }
      );
    }

  };
}();

/*
  /************************************************************************
   * Scratchpad
   ************************************************************************/
/*

  function searchBox() {

    var data = [
      { label: "H-Drol", category: "Prohormones" },
      { label: "Havoc", category: "Prohormones" },
      { label: "Ultradrol", category: "Prohormones" },
      { label: "DAA Caps", category: "Products" },
      { label: "Cycle Assist", category: "Products" },
      { label: "PCT Assist", category: "Post Cycle Therapy" },
      { label: "Piracetam", category: "Products" },
      { label: "Recycle", category: "Products" },
      { label: "M5", category: "Products" },
      { label: "P6", category: "Prohormones" },
      { label: "NO Extreme", category: "Products" },
      { label: "EP-Stane", category: "Prohormones" },
      { label: "OxyElite Pro", category: "Products" }
    ];

    $.widget("custom.catcomplete", $.ui.autocomplete, {
      _renderMenu: function (ul, items) {
        var that = this, currentCategory = "";
        $.each(items, function (admin, item) {
          if (item.category !== currentCategory) {
            ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
            currentCategory = item.category;
          }
          that._renderItemData(ul, item);
        });
      }
    });
    
    $("#searchbox").catcomplete({
      delay: 0,
      source: data
    });
  }

function insertRecord(){

  //validate record
  var account = Object.create(null);
  account.id = $("#txtId").val();
  account.rtype = $("#drpRType").val();
  account.name = $("#txtName").val();
  account.modifyDate = $("#txtDateModified").val();
  account.description = $("#txtDescription").val();

  $.ajax({
      type: "POST",
      url: "/accounting/accounts",
      data: JSON.stringify(account),
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      success: function (response) {
        addRowToTable(response);
      },
      error: function (xhr, ajaxOptions, thrownError) {
            alert(thrownError);
      }
  });
}

function addRowToTable(account){

  $('#dataTable').dataTable().fnAddData([
    account.id,
    '<div id="pop-up-'+account.name+'" class="pop-up" >'+ account.description +'</div>' +
    '<div id="pop-up-trigger-'+account.name+'">'+ account.name +'</div>',
    account.rtype,
    account.modifyDate
  ]);
  addPopup(account.name);
}

function addPopup(id){
  $('div#pop-up-trigger-'+id).hover(
    function(e) {
      $('div#pop-up-'+id).show()
        .css('top',  e.pageY + 20)
        .css('left', e.pageX + 10)
        .appendTo('body');
    }, function() {
      $('div#pop-up-'+id).hide();
  });
}

************************************************************************
validator
************************************************************************

    required: function( value, element, param ) {
      // check if dependency is met
      if ( !this.depend(param, element) ) {
        return "dependency-mismatch";
      }
      if ( element.nodeName.toLowerCase() === "select" ) {
        // could be an array for select-multiple or a string, both are fine this way
        var val = $(element).val();
        return val && val.length > 0;
      }
      if ( this.checkable(element) ) {
        return this.getLength(value, element) > 0;
      }
      return $.trim(value).length > 0;
    },

    // http://docs.jquery.com/Plugins/Validation/Methods/email
    email: function( value, element ) {
      // contributed by Scott Gonzalez: http://projects.scottsplayground.com/email_address_validation/
      return this.optional(element) || /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/i.test(value);
    },

    // http://docs.jquery.com/Plugins/Validation/Methods/url
    url: function( value, element ) {
      // contributed by Scott Gonzalez: http://projects.scottsplayground.com/iri/
      return this.optional(element) || /^(https?|s?ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(value);
    },

    // http://docs.jquery.com/Plugins/Validation/Methods/date
    date: function( value, element ) {
      return this.optional(element) || !/Invalid|NaN/.test(new Date(value).toString());
    },

    // http://docs.jquery.com/Plugins/Validation/Methods/dateISO
    dateISO: function( value, element ) {
      return this.optional(element) || /^\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2}$/.test(value);
    },

    // http://docs.jquery.com/Plugins/Validation/Methods/number
    number: function( value, element ) {
      return this.optional(element) || /^-?(?:\d+|\d{1,3}(?:,\d{3})+)?(?:\.\d+)?$/.test(value);
    },

    // http://docs.jquery.com/Plugins/Validation/Methods/digits
    digits: function( value, element ) {
      return this.optional(element) || /^\d+$/.test(value);
    },

    // http://docs.jquery.com/Plugins/Validation/Methods/creditcard
    // based on http://en.wikipedia.org/wiki/Luhn
    creditcard: function( value, element ) {
      if ( this.optional(element) ) {
        return "dependency-mismatch";
      }
      // accept only spaces, digits and dashes
      if ( /[^0-9 \-]+/.test(value) ) {
        return false;
      }
      var nCheck = 0,
        nDigit = 0,
        bEven = false;

      value = value.replace(/\D/g, "");

      for (var n = value.length - 1; n >= 0; n--) {
        var cDigit = value.charAt(n);
        nDigit = parseInt(cDigit, 10);
        if ( bEven ) {
          if ( (nDigit *= 2) > 9 ) {
            nDigit -= 9;
          }
        }
        nCheck += nDigit;
        bEven = !bEven;
      }

      return (nCheck % 10) === 0;
    },

    // http://docs.jquery.com/Plugins/Validation/Methods/minlength
    minlength: function( value, element, param ) {
      var length = $.isArray( value ) ? value.length : this.getLength($.trim(value), element);
      return this.optional(element) || length >= param;
    },

    // http://docs.jquery.com/Plugins/Validation/Methods/maxlength
    maxlength: function( value, element, param ) {
      var length = $.isArray( value ) ? value.length : this.getLength($.trim(value), element);
      return this.optional(element) || length <= param;
    },

    // http://docs.jquery.com/Plugins/Validation/Methods/rangelength
    rangelength: function( value, element, param ) {
      var length = $.isArray( value ) ? value.length : this.getLength($.trim(value), element);
      return this.optional(element) || ( length >= param[0] && length <= param[1] );
    },

    // http://docs.jquery.com/Plugins/Validation/Methods/min
    min: function( value, element, param ) {
      return this.optional(element) || value >= param;
    },

    // http://docs.jquery.com/Plugins/Validation/Methods/max
    max: function( value, element, param ) {
      return this.optional(element) || value <= param;
    },

    // http://docs.jquery.com/Plugins/Validation/Methods/range
    range: function( value, element, param ) {
      return this.optional(element) || ( value >= param[0] && value <= param[1] );
    },

    // http://docs.jquery.com/Plugins/Validation/Methods/equalTo
    equalTo: function( value, element, param ) {
      // bind to the blur event of the target in order to revalidate whenever the target field is updated
      // TODO find a way to bind the event just once, avoiding the unbind-rebind overhead
      var target = $(param);
      if ( this.settings.onfocusout ) {
        target.unbind(".validate-equalTo").bind("blur.validate-equalTo", function() {
          $(element).valid();
        });
      }
      return value === target.val();
    },

*/