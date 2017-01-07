$(document).ready(function(){

  $('.nav-bar .menu').on('click', function(){
    var $side_bar = $('.side-bar');

    if($side_bar.hasClass("opened")) {
      $('.nav-bar').removeClass("bgmode");
      $('.content-container').removeClass("bgmode");
      $side_bar.removeClass("opened");
    } else {
      $('.nav-bar').addClass("bgmode");
      $('.content-container').addClass("bgmode");
      $side_bar.addClass("opened");
    }
  })
});
