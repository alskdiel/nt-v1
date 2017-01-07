$(document).ready(function(){

  $modal_background = $('.modal-background');
  $side_bar = $('.side-bar');

  $('.nav-bar .menu').on('click', function(){
    openSidebar();
  });

  $('.side-bar .close').on('click', function(){
    closeSidebar();
  });


  function openSidebar() {
    $modal_background.addClass('sidebar-opened');
    $side_bar.addClass('opened');
  }

  function closeSidebar() {
    $modal_background.removeClass('sidebar-opened');
    $side_bar.removeClass('opened');
  }
});
