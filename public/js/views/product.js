
/************************************************************************
 * product view
 ************************************************************************/
  function viewMain (tess) {
  'use strict';

  $(function(){
    $('#imgGallery').galleryView({
      show_panel_nav: false,
      panel_width: 300,
      panel_height: 330,
      frame_width: 83,
      frame_height: 70,
      enable_slideshow: false,
      show_filmstrip_nav: false,
      autoplay: false,
      filmstrip_position: 'left',
      frame_scale: 'fit'
    });
  });

}