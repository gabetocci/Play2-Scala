
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

  // admin navigation
  tess.setActiveNavItem(tess.currentPath);

  // search bar
  $("#searchDropdownBox").change(function(){
    var Search_Str = $(this).val();
    //replace search str in span value
    $("#nav-search-in-content").text(Search_Str);
  });

  /************************************************************************
   * footer
   ************************************************************************/

  // copyright
  var year = tess.currentDate.getFullYear();
  $("span#copyright").text(
    String.fromCharCode(169) + " " + year + " StealStation.com All Rights Reserved");
}


