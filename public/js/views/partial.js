
function partialViewMain (tess) {
  'use strict';

  /************************************************************************
   * header
   ************************************************************************/

  // departments menu
  var $menu = $(".dropdown-menu");

  $menu.menuAim({
    activate: activateSubmenu,
    deactivate: deactivateSubmenu
  });

  function activateSubmenu(row) {
    var $row = $(row),
      submenuId = $row.data("submenuId"),
      $submenu = $("#" + submenuId),
      height = $menu.outerHeight(),
      width = $menu.outerWidth();

    // Show the submenu
    $submenu.css({
      display: "block",
      top: -1,
      left: width -3  // main should overlay submenu
      //height: height - 4  // padding for main dropdown's arrow
    });

    // Keep the currently activated row's highlighted look
    $row.find("a").addClass("maintainHover");
  }

  function deactivateSubmenu(row) {
    var $row = $(row),
      submenuId = $row.data("submenuId"),
      $submenu = $("#" + submenuId);

    // Hide the submenu and remove the row's highlighted look
    $submenu.css("display", "none");
    $row.find("a").removeClass("maintainHover");
  }

  // Bootstrap's dropdown menus immediately close on document click.
  // Don't let this event close the menu if a submenu is being clicked.
  // This event propagation control doesn't belong in the menu-aim plugin
  // itself because the plugin is agnostic to bootstrap.
  $("#departments-menu-list li").click(function(e) {
    e.stopPropagation();
  });

  $(document).click(function() {
    // Simply hide the submenu on any click. Again, this is just a hacked
    // together menu/submenu structure to show the use of jQuery-menu-aim.
    $(".popover").css("display", "none");
    $("a.maintainHover").removeClass("maintainHover");
  });

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
              "<img src='/assets/img/arrow_up.png' title='+1' class='cartarrow' alt='arrow up' />" +
            "</a>" +
            "<a href='javascript:;' class='simpleCart_decrement'>" +
              "<img src='/assets/img/arrow_down.png' title='-1' class='cartarrow' alt='arrow down' />" +
            "</a>" +
          "</div>";
      }, attr: 'custom', label: "Quantity" },
      //Name of the item
      { attr: "name" , label: "Name" },
      //Subtotal of that row (quantity of that item * the price)
      { view: 'currency', attr: "total" , label: "Price"  }
    ],
    cartStyle: 'table',
    checkout: {
      type: "PayPal" ,
      email: "payments@stealstation.com"
    }
  });

  // admin navigation
  tess.setActiveNavItem(tess.currentPath);

  /*  TODO Hide Popovers when clicked off
  $(document).click(function() {
    $("#cartPopover").css("display", "none");
    $("#departments-menu-flyover").hide(); //css("display", "none");

    //$("a.maintainHover").removeClass("maintainHover");
  });
  */

  /************************************************************************
   * footer
   ************************************************************************/

  // copyright
  var year = tess.currentDate.getFullYear();
  $("span#copyright").text(
    String.fromCharCode(169) + " " + year + " StealStation.com All Rights Reserved");
}
