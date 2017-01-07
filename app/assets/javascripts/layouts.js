$(document).ready(function(){

  $side_bar_bg = $('.side-bar-background');
  $side_bar = $('.side-bar');

  $('.nav-bar .menu').on('click', function(){
    openSidebar();
  });

  $('.side-bar .cancel').on('click', function(){
    closeSidebar();
  });

  $('.side-bar .user-info').on('click', function(){
    $("#modal-sign-in").modal();
  });

  $('.side-bar .followings').on('click', function(){
    $("#modal-test").modal();
  });


  function openSidebar() {
    $side_bar_bg.addClass('sidebar-opened');
    $side_bar.addClass('opened');
  }

  function closeSidebar() {
    $side_bar_bg.removeClass('sidebar-opened');
    $side_bar.removeClass('opened');
  }

});
