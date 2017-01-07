$(document).ready(function(){

  $('.nav-bar .menu').on('click', function(){
    var isVisible = $('.side-bar').css('visibility');
    if(isVisible == 'hidden') {
      $('.side-bar').css('visibility', 'visible');
    } else {
      $('.side-bar').css('visibility', 'hidden');
    }
  })
});
