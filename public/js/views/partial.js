
function partialViewMain (tess) {
  'use strict';

  /************************************************************************
   * header
   ************************************************************************/

  // login box
  $("#login-link").click(function() {
    $("#dialog-box-background").css({"opacity":"0.4"});
    $("#dialog-box-background").fadeIn("slow");
    $("#login-box").fadeIn('fast');
  });
  $("#login-close-btn").click(function() {
    $("#login-box").hide();
    $("#dialog-box-background").fadeOut("slow");
  });

  // search bar
  $("#searchDropdownBox").change(function(){
    var Search_Str = $(this).val();
    //replace search str in span value
    $("#nav-search-in-content").text(Search_Str);
  });
  $("#search-button").click(function() {
    window.location = "/catalog";
  });

  // shopping cart
  $("#cart-anchor").click(function() {
    $("#cartPopover").toggle();
    $("#cartPopoverClose").toggle();
  });

  simpleCart({
    //Setting the Cart Columns for the sidebar cart display.
    cartColumns: [
      //A custom cart column for putting the quantity and increment and decrement items in one div for easier styling.
      { view: function(item, column){
        return	"<span>"+item.get('quantity')+"</span>" +
          "<div>" +
            "<a href='javascript:;' class='simpleCart_increment'>" +
              "<img src='/assets/img/increment.png' title='+1' alt='arrow up'/>" +
            "</a>" +
            "<a href='javascript:;' class='simpleCart_decrement'>" +
              "<img src='/assets/img/decrement.png' title='-1' alt='arrow down'/>" +
            "</a>" +
          "</div>";
      }, attr: 'custom' },
      //Name of the item
      { attr: "name" , label: false },
      //Subtotal of that row (quantity of that item * the price)
      { view: 'currency', attr: "total" , label: false  }
    ],
    cartStyle: 'div',
    checkout: {
      type: "PayPal" ,
      email: "payments@stealstation.com"
    }
  });

  // admin navigation
  tess.setActiveNavItem(tess.currentPath);

  /************************************************************************
   * footer
   ************************************************************************/

  // copyright
  var year = tess.currentDate.getFullYear();
  $("span#copyright").text(
    String.fromCharCode(169) + " " + year + " StealStation.com All Rights Reserved");
}


